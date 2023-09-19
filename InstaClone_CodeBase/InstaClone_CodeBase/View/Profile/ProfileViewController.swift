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
        [profilePageView.profileLabelView.followerNumberLabel, profilePageView.profileLabelView.followingNumberLabel].forEach { $0?.text = "\(Int.random(in: 100 ... 300))" }
        
        let websiteLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteClicked))
        profilePageView.descriptionView.websiteLabel.addGestureRecognizer(websiteLabelTapGesture)
        profilePageView.descriptionView.websiteLabel.isUserInteractionEnabled = true
        
        //
        profilePageView.profileImageView.delegate = self
    }
    
    @objc func websiteClicked() {
        if let websiteURLString = profilePageView.descriptionView.websiteLabel.text, let url = URL(string: websiteURLString) {
            UIApplication.shared.open(url)
        }
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
        let addFeedButton = UIBarButtonItem(image: UIImage(named: "Plus"), style: .plain, target: self, action: #selector(addImage))
        let menuButton = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: nil)
        addFeedButton.tintColor = .black
        addFeedButton.width = 20
        menuButton.tintColor = .black
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: leftLockImageView), leftButton]
        navigationItem.rightBarButtonItems = [menuButton, addFeedButton]
    }
    
    @objc func addImage() {
        didSelectProfileImage()
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
            // 프로필 이미지 업데이트
            profilePageView.profileImageView.profileImageView.image = selectedImage
            profilePageView.postView.profileViewModel.postFeed.insert(selectedImage, at: 0)
            profilePageView.profileLabelView.postNumberLabel.text = String(profilePageView.postView.profileViewModel.postFeed.count)
            profilePageView.postView.postsCollectionView.reloadData()
            
            dismiss(animated: true, completion: nil)
        }
    }
}
