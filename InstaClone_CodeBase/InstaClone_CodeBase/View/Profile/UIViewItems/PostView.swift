import UIKit

final class PostView: UIView {
    let screenSize = UIScreen.main.bounds.size
    var postFeed: [UIImage?] = [
        UIImage(named: "Grid"),
        UIImage(named: "Tags")
    ]

    // Posts 버튼
    lazy var postsButton: UIButton = {
        let button = UIButton(type: .system)
        configureButton(button, imageName: "Grid", target: self, action: #selector(postsButtonTapped))
        return button
    }()

    // 태그된 게시글 버튼
    lazy var taggedPostsButton: UIButton = {
        let button = UIButton(type: .system)
        configureButton(button, imageName: "Tags", target: self, action: #selector(taggedPostsButtonTapped))
        return button
    }()

    // 버튼 선택 시, 아래의 선
    lazy var line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    // 스택 뷰에 버튼을 감싸는 컨테이너 뷰 추가
    private lazy var buttonContainerView: UIView = {
        let buttons = [postsButton, taggedPostsButton]
        return wrapButtonsInContainerView(buttons, width: 350, height: 30)
    }()

    // 스택 뷰
    lazy var postBarItems: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonContainerView])
        stackView.horizontalStackView(spacing: 5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    //================================================== 👇🏻Collection View Custom 시작 ==================================================

    // 게시글 컬렉션뷰
    lazy var postsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (screenSize.width - 2) / 3, height: (screenSize.width - 2) / 3)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //collectionView.backgroundColor = .white

        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    // 태그된 게시글
    lazy var taggedPostsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // story
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (screenSize.width - 2) / 3, height: (screenSize.width - 2) / 3)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        // 셀 등록
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")

        // 데이터 소스 및 델리게이트 설정
        collectionView.dataSource = self
        //collectionView.delegate = self

        return collectionView
    }()

    // ================================================ 버튼 기능 =====================================================

    @objc func postsButtonTapped() {
        postsCollectionView.isHidden = false
        taggedPostsCollectionView.isHidden = true

        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.line.center.x = self.postsButton.center.x + 20
        }
    }

    @objc func taggedPostsButtonTapped() {
        postsCollectionView.isHidden = true
        taggedPostsCollectionView.isHidden = false

        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.line.center.x = self.taggedPostsButton.center.x + 20
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // postsCollectionView의 데이터 소스 및 델리게이트 설정
            postsCollectionView.dataSource = self
            postsCollectionView.delegate = self
            
            // taggedPostsCollectionView의 데이터 소스 및 델리게이트 설정
            taggedPostsCollectionView.dataSource = self
            taggedPostsCollectionView.delegate = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("ERROR")
    }
}

extension PostView {
    // 공통작업 기능
    func configureButton(_ button: UIButton, imageName: String, target: Any, action: Selector) {
        button.translatesAutoresizingMaskIntoConstraints = false

        if let buttonImage = UIImage(named: imageName) {
            let imageSize = CGSize(width: 20, height: 20)
            UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
            buttonImage.draw(in: CGRect(origin: .zero, size: imageSize))

            if let resizedImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                button.setImage(resizedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                UIGraphicsEndImageContext()
            }
        }

        // 버튼 디자인
        button.backgroundColor = UIColor.systemBackground
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 5

        // 기능 추가
        button.addTarget(target, action: action, for: .touchUpInside)
    }

    func wrapButtonsInContainerView(_ buttons: [UIButton], width: CGFloat, height: CGFloat) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: height).isActive = true

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center // 중앙 정렬 추가
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually // 버튼 간격 동일하게 분배

        containerView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        return containerView
    }
}
