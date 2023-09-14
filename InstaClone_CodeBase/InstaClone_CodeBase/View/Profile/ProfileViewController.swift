import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    let profileImageStackView = ProfileImageStackView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        customNavigationBarButtons()
        

        view.addSubview(profileImageStackView)
    }
}

extension ProfileViewController {
    //네비게이션 바 버튼들 커스텀 하기
    private func customNavigationBarButtons(){
        //왼쪽
        let leftLockImage = UIImage(systemName: "lock.fill")
        let leftLockImageView = UIImageView(image: leftLockImage)
        leftLockImageView.tintColor = .black

        let leftButton = UIBarButtonItem(title: "lunamoon_u", style: .plain, target: self, action: nil)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 25), // 폰트 크기 조절
            .foregroundColor: UIColor.black // 텍스트 색상 설정
        ]

        leftButton.setTitleTextAttributes(attributes, for: .normal)
        leftButton.tintColor = .black
        
        //오른쪽
        let menuButton = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: nil)
        menuButton.tintColor = .black
        
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: leftLockImageView), leftButton]
        navigationItem.rightBarButtonItem = menuButton
    }
    
    
    
}
