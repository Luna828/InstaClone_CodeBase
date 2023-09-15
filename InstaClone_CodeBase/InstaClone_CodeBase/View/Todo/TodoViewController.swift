import SnapKit
import UIKit

class TodoViewController: UIViewController {
    private var tableView: UITableView!
    private let sectionNames = ["Work", "Life"]

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
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Todo 생성", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "오늘의 Todo를 입력해주세요"
        }

        let availableSections = ["Work", "Life"]

        for section in availableSections {
            alertController.addAction(UIAlertAction(title: section, style: .default) {_ in
                if let contentField = alertController.textFields?.first,
                   let content = contentField.text
                {
                    if content.isEmpty {
                        let alertEmpty = UIAlertController(title: "할일을 작성해주세요", message: nil, preferredStyle: .alert)
                        alertEmpty.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                        self.present(alertEmpty, animated: true, completion: nil)
                    } else {
                        // CoreData 연결부분
                        //let newTodo = Todo(content: content, isCompleted: false)
                    }
                }
            })
        }
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell

        // cell에 데이터 설정
        // cell.configure(with: yourDataArray[indexPath.row])

        return cell
    }

    // UITableViewDelegate 메서드 구현
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
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
}
