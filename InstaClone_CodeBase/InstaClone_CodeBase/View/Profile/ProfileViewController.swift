import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    let profileImageStackView = ProfileImageStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "lock.fill"), style: .plain, target: self, action: nil)
            leftButton.title = "lunamoon_u" // 타이틀 추가
        leftButton.tintColor = .black
            self.navigationItem.leftBarButtonItem = leftButton
               
        view.addSubview(profileImageStackView)
        
    }
    
    
}

extension ProfileViewController {
    
}
