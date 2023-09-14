import SnapKit
import UIKit

class ProfileViewController: UIViewController, ProfileImageViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let profileImageStackView = ProfileImageViews()
    let imagePicker = UIImagePickerController()
    
    func didSelectProfileImage() {
        self.imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if info[.originalImage] is UIImage {
            // 이미지를 업데이트하거나 필요한 작업 수행
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    override func loadView() {
        view = profileImageStackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        customNavigationBarButtons()
        profileImageStackView.setupGesture()
        
        profileImageStackView.delegate = self
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
