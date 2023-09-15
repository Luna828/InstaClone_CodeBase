import SnapKit
import UIKit

class ProfileViewController: UIViewController, ProfileImageViewDelegate {
    let profilePageView = ProfilePageView()
    let imagePicker = UIImagePickerController()
    
    override func loadView() {
        view = profilePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        customNavigationBarButtons()
        profilePageView.profileImageView.setupGesture()
        
        profilePageView.profileImageView.delegate = self
    }
}

extension ProfileViewController {
    // 네비게이션 바 버튼들 커스텀 하기
    private func customNavigationBarButtons() {
        // 왼쪽
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
        
        // 오른쪽
        let menuButton = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: nil)
        menuButton.tintColor = .black
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: leftLockImageView), leftButton]
        navigationItem.rightBarButtonItem = menuButton
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func didSelectProfileImage() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePageView.profileImageView.profileImageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
}
