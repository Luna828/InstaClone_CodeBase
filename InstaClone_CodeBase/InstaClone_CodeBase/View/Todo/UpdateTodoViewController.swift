import SnapKit
import UIKit

protocol UpdateTodoDelegate: AnyObject {
    func updateTodo()
}

class UpdateTodoViewController: UIViewController {
    weak var delegate: UpdateTodoDelegate?
    var todo: Todo?

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
        
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
        
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = true // 수정 가능하도록 설정
        textView.isScrollEnabled = true // 스크롤 가능하도록 설정
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
        view.addSubview(textView)
        textView.text = todo?.content ?? ""
        textView.frame = CGRect(x: 0, y: 70, width: view.frame.width, height: view.frame.height)
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
            
        setupLayout()
    }

    func setupLayout() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
            
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
    }
        
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
        
    @objc func confirmButtonTapped() {
          if let updatedContent = textView.text {

              if let existingTodo = todo, existingTodo.content != updatedContent {
                  existingTodo.content = updatedContent
                  TodoService.shared.updateTodo(existingTodo)
                  
              }
          }
        delegate?.updateTodo()
        dismiss(animated: true, completion: nil)
    }
}


