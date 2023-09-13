import SnapKit
import UIKit

class MainViewController: UIViewController {
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
        self.navigationItem.rightBarButtonItem = addButton
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "todoTableCell")
    }
    
    @objc func addButtonTapped(){
        print("와우")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // UITableViewDataSource 메서드 구현
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 소스의 행 개수를 반환
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // UITableViewCell을 생성하고 구성하여 반환
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCell", for: indexPath) as! TodoTableViewCell

        // cell에 데이터 설정
        // cell.configure(with: yourDataArray[indexPath.row])

        return cell
    }

    // UITableViewDelegate 메서드 구현
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // UITableViewCell의 높이를 설정
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
