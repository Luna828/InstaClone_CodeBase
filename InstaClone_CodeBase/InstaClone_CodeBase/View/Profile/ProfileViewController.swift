import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    let profilePageView = ProfilePageView()
    let imagePicker = UIImagePickerController()
    
    var viewModel = ProfileViewModel()
    
    override func loadView() {
        view = profilePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Local 변수 설정
        let imageView = profilePageView.profileImageView
        let labelView = profilePageView.profileLabelView
        let descriptionView = profilePageView.descriptionView
        
        customNavigationBarButtons()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectProfileImage))
        imageView.profileImageView.addGestureRecognizer(tapGesture)
        imageView.profileImageView.isUserInteractionEnabled = true
        imageView.changeImageButton.addTarget(self, action: #selector(didSelectProfileImage), for: .touchUpInside)
        labelView.followerNumberLabel.text = String(viewModel.followerCount)
        labelView.followingNumberLabel.text = String(viewModel.followingCount)
        
        let websiteLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteClicked))
        descriptionView.websiteLabel.addGestureRecognizer(websiteLabelTapGesture)
        descriptionView.websiteLabel.isUserInteractionEnabled = true
    }
    
    @objc func websiteClicked() {
        viewModel.websiteClicked(websiteURLString: profilePageView.descriptionView.websiteLabel.text)
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
    @objc func didSelectProfileImage() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageView = profilePageView.profileImageView
            let postView = profilePageView.postView
            let labelView = profilePageView.profileLabelView
            // 프로필 이미지 업데이트
            imageView.profileImageView.image = selectedImage
            postView.profileViewModel.postFeed.insert(selectedImage, at: 0)
            labelView.postNumberLabel.text = String(postView.profileViewModel.postCount)
            postView.postsCollectionView.reloadData()
            
            dismiss(animated: true, completion: nil)
        }
    }
}
