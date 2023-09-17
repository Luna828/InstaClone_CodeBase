import SnapKit
import UIKit

class TodoViewController: UIViewController {
    private var tableView: UITableView!
    private let sectionNames = ["Work", "Life"]
    var todo: Todo?

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

        for sectionName in sectionNames {
            TodoService.shared.fetchTodo(for: sectionName)
        }
        tableView.reloadData()
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Todo 생성", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "오늘의 Todo를 입력해주세요"
        }

        let availableSections = ["Work", "Life"]

        for section in availableSections {
            alertController.addAction(UIAlertAction(title: section, style: .default) { _ in
                if let contentField = alertController.textFields?.first,
                   let content = contentField.text
                {
                    if content.isEmpty {
                        let alertEmpty = UIAlertController(title: "할일을 작성해주세요", message: nil, preferredStyle: .alert)
                        alertEmpty.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                        self.present(alertEmpty, animated: true, completion: nil)
                    } else {
                        // CoreData 연결부분
                        let newTodo = Todo(context: TodoService.shared.mainContext)
                        newTodo.content = content
                        TodoService.shared.addNewTodo(newTodo, to: section)
                        print(section)
                        print(TodoService.shared.todoList)
                        TodoService.shared.fetchTodo(for: section)
                        self.tableView.reloadData()
                    }
                }
            })
        }

        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

extension TodoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = sectionNames[section]
        return TodoService.shared.todoList.filter { $0.section == sectionName }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell
        let sectionName = sectionNames[indexPath.section]
        let todos = TodoService.shared.todoList

        if sectionName == "Work" {
            if indexPath.row < todos.filter({ $0.section == "Work" }).count {
                let workTodos = todos.filter { $0.section == "Work" }
                cell.leftLabel.text = workTodos[indexPath.row].content
                cell.dateLabel.text = dateFormatter.string(for: workTodos[indexPath.row].date)
                cell.toggleSwitch.isOn = workTodos[indexPath.row].isChecked
                cell.toggleSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
            } else {
                cell.leftLabel.text = "No TODO"
            }
            return cell
        } else if sectionName == "Life" {
            if indexPath.row < todos.filter({ $0.section == "Life" }).count {
                let lifeTodos = todos.filter { $0.section == "Life" }
                cell.leftLabel.text = lifeTodos[indexPath.row].content
                cell.dateLabel.text = dateFormatter.string(for: lifeTodos[indexPath.row].date)
                cell.toggleSwitch.isOn = lifeTodos[indexPath.row].isChecked
                cell.toggleSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
            } else {
                cell.leftLabel.text = "No TODO"
            }
            return cell
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
        
        let sectionName = sectionNames[indexPath.section]
        let todosInSection = TodoService.shared.todoList
        
        if sectionName == "Work" {
            if indexPath.row < todosInSection.filter({ $0.section == "Work" }).count {
                let workTodos = todosInSection.filter { $0.section == "Work" }
                workTodos[indexPath.row].isChecked = sender.isOn
                dump(workTodos[indexPath.row].isChecked)
                TodoService.shared.updateTodo(workTodos[indexPath.row])
            } else {
                
            }
        } else if sectionName == "Life" {
            if indexPath.row < todosInSection.filter({ $0.section == "Life" }).count {
                let lifeTodos = todosInSection.filter { $0.section == "Life" }
                lifeTodos[indexPath.row].isChecked = sender.isOn
                dump(lifeTodos[indexPath.row].isChecked)
                TodoService.shared.updateTodo(lifeTodos[indexPath.row])
            } else {
                
            }
        }
    }

    // 섹션 헤더 뷰 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerView.backgroundColor = .white

        let titleLabel = UILabel(frame: headerView.bounds)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = sectionNames[section]
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

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
            let deletedTodo = TodoService.shared.todoList.remove(at: indexPath.row)
            TodoService.shared.deleteTodo(deletedTodo)
            tableView.deleteRows(at: [indexPath], with: .fade)

            // 해당 섹션 내의 항목이 더 이상 없는지 확인
            let sectionName = sectionNames[indexPath.section]
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
        let selectedTodo = TodoService.shared.todoList[indexPath.row]
        let modalViewController = UpdateTodoViewController()
        modalViewController.todo = selectedTodo
        // 이 설정을 꼭해줘야.. tableView.reload 먹힘
        modalViewController.delegate = self

        present(modalViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
