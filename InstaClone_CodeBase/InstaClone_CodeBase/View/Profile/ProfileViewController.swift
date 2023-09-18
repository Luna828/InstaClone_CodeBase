import SnapKit
import UIKit

class ProfileViewController: UIViewController, ProfileImageViewDelegate {
    
    let profilePageView = ProfilePageView()
    //let postView = PostView()
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
        
//        postView.postsCollectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
//        postView.postsCollectionView.dataSource = self
//        postView.postsCollectionView.delegate = self
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
            
            //postView.postFeed.append(selectedImage)
//            print("postView.postFeed = \(postView.postFeed)")
//            print("나옴? \(postView.postFeed.count)")
            
            profilePageView.postView.postFeed.insert(selectedImage, at: 0)
            profilePageView.postView.postsCollectionView.reloadData()
            
            dismiss(animated: true, completion: nil)
        }
    }
}
