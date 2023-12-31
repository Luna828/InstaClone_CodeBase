import SnapKit
import UIKit

class TodoViewController: UIViewController {
    private var tableView: UITableView!
    private var viewModel = TodoViewModel()
    let dateFormatter = DateFormat().formatter

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton: UIBarButtonItem = {
            let addButton = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addButtonTapped)
            )
            return addButton
        }()

        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = addButton

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "todoTableCell")

        // 뷰모델의 todoList 변경 시 테이블 뷰를 다시 로드
        viewModel.todoListDidChange = { [weak self] in
            self?.tableView.reloadData()
        }

        for sectionName in viewModel.sectionNames {
            viewModel.fetchTodos(for: sectionName)
        }
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Todo 생성", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "오늘의 Todo를 입력해주세요"
        }

        let availableSections = viewModel.sectionNames

        for section in availableSections {
            alertController.addAction(UIAlertAction(title: section, style: .default) { [weak self] _ in
                if let contentField = alertController.textFields?.first,
                   let content = contentField.text
                {
                    self?.viewModel.addNewTodo(content: content, to: section)
                }
            })
        }

        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

extension TodoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionNames.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionNames[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = viewModel.sectionNames[section]
        return viewModel.todoService.todoList.filter { $0.section == sectionName }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell
        let sectionName = viewModel.sectionNames[indexPath.section]
        let todos = viewModel.todoService.todoList.filter { $0.section == sectionName }

        if indexPath.row < todos.count {
            let todo = todos[indexPath.row]
            cell.leftLabel.text = todo.content
            cell.dateLabel.text = dateFormatter.string(for: todo.date)
            cell.toggleSwitch.isOn = todo.isChecked
            cell.toggleSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        } else {
            cell.leftLabel.text = "No TODO"
        }
        return cell
    }

    @objc func switchValueChanged(_ sender: UISwitch) {
        guard let cell = sender.superview?.superview as? TodoTableViewCell else {
            print("TodoTableCell을 찾을 수 없습니다")
            return
        }

        // 셀에서 indexPath 가져오기
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("indexPath를 찾을 수 없습니다")
            return
        }

        let sectionName = viewModel.sectionNames[indexPath.section]
        let todosInSection = TodoService.shared.todoList.filter { $0.section == sectionName }

        if indexPath.row < todosInSection.count {
            var updatedTodo: Todo
            let todo = todosInSection[indexPath.row]
            todo.isChecked = sender.isOn
            updatedTodo = todo
            dump(updatedTodo.isChecked)
            TodoService.shared.updateTodo(updatedTodo)
        }
    }

    // 섹션 헤더 뷰 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerView.backgroundColor = .white

        let titleLabel = UILabel(frame: headerView.bounds)
        titleLabel.customLabel(text: viewModel.sectionNames[section], textColor: .black, font: UIFont.systemFont(ofSize: 20, weight: .bold))
        titleLabel.textAlignment = .left

        headerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView).offset(16)
            make.trailing.equalTo(headerView).offset(-16)
            make.top.equalTo(headerView)
            make.bottom.equalTo(headerView)
        }
        return headerView
    }

    // 섹션 헤더 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sectionName = viewModel.sectionNames[indexPath.section]
            let selectedTodosInSection = TodoService.shared.todoList.filter { $0.section == sectionName }
            guard indexPath.row < selectedTodosInSection.count else {
                return
            }
            let deletedTodo = selectedTodosInSection[indexPath.row]

            // 할 일 삭제 + 테이블 뷰에서 해당 행을 삭제
            TodoService.shared.deleteTodo(deletedTodo)
            tableView.deleteRows(at: [indexPath], with: .fade)

            // 해당 섹션 내의 항목이 더 이상 없는지 확인
            let todosInSection = TodoService.shared.todoList.filter { $0.section == sectionName }
            if todosInSection.isEmpty {
                // 해당 섹션에 항목이 없으면 없는 셀을 보여줌 -> 있는 척하는데 없음 ㅋㅋㅋㅋㅋ
                let indexPathForSection = IndexPath(row: 0, section: indexPath.section)
                tableView.reloadRows(at: [indexPathForSection], with: .automatic)
            }
        }
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionName = viewModel.sectionNames[indexPath.section]
        let selectedTodos = TodoService.shared.todoList.filter { $0.section == sectionName }

        if indexPath.row < selectedTodos.count {
            let modalViewController = UpdateTodoViewController()
            modalViewController.todo = selectedTodos[indexPath.row]
            modalViewController.delegate = self
            present(modalViewController, animated: true, completion: nil)
        }
    }
}

extension TodoViewController: UpdateTodoDelegate {
    func updateTodo() {
        tableView.reloadData()
    }

    func showUpdateTodoViewController() {
        let updateTodoVC = UpdateTodoViewController()
        updateTodoVC.delegate = self
    }
}
