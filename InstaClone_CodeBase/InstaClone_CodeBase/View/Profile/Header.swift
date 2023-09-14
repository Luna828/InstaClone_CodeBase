import SnapKit
import UIKit

class Header: UIView {
    let profileImageView = ProfileImageViews()
    let profileLabelView = ProfileLabelViews()
    let descriptionView = DescriptionView()
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

        profileStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(profileStackView.snp.top).offset(210)
        }
        
        //여기는 이상하게 안걸리네..
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.top.equalTo(labelStackView.snp.top).offset(80)
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
