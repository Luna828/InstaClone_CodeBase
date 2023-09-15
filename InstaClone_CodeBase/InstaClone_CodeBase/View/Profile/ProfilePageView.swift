import SnapKit
import UIKit

final class ProfilePageView: UIView {
    let profileImageView = ProfileImageViews()
    let profileLabelView = ProfileLabelViews()
    let descriptionView = DescriptionView()
    let postView = PostView()
    // 전체 스택뷰
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, profileLabelView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                descriptionView.nameLabel,
                descriptionView.descriptionLabel,
                descriptionView.websiteLabel,
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 3

        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionView.followButton, descriptionView.messageButton, descriptionView.moreButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private func setupConstraints(){
        addSubview(profileStackView)
        addSubview(labelStackView)
        addSubview(buttonStackView)
        addSubview(postView.postBarItems)
        addSubview(postView.line)
        addSubview(postView.postsCollectionView)
        addSubview(postView.taggedPostsCollectionView)

        profileStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(profileStackView.snp.top).offset(210)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(10)
            make.leading.equalTo(labelStackView)
            make.trailing.equalTo(labelStackView)
            make.height.equalTo(26)
        }
        
        postView.postBarItems.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.top).offset(40)
            make.leading.equalTo(buttonStackView)
            make.trailing.equalTo(buttonStackView)
        }
        
        postView.line.snp.makeConstraints { make in
            make.top.equalTo(postView.postBarItems.snp.bottom)
            make.height.equalTo(1)
            make.width.equalTo(postView.postsButton.snp.width)
            make.centerX.equalTo(postView.postsButton.snp.centerX)
        }

        postView.postsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(postView.postBarItems.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        postView.taggedPostsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(postView.postBarItems.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("ERROR")
    }
}
