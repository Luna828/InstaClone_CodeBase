import SnapKit
import UIKit

protocol ProfileImageViewDelegate: AnyObject {
    func didSelectProfileImage()
}

final class ProfileImageViews: UIView {
    weak var delegate: ProfileImageViewDelegate?

    // 프로필 이미지 뷰
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "moomin")
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    //프로필 이미지에 제스처 설정
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }

    //제스처 클릭 함수실행
    @objc func profileImageTapped() {
        delegate?.didSelectProfileImage()
    }

    // 그림자 뷰
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 7
        view.layer.cornerRadius = 50

        return view
    }()

    // + 버튼
    lazy var changeImageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.tintColor = .systemBlue
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        btn.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)

        return btn
    }()

    private func setupConstraints() {
        addSubview(profileImageView)
        addSubview(changeImageButton)

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(30)
            make.width.height.equalTo(80)
        }

        changeImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(50)
            make.trailing.equalTo(profileImageView.snp.trailing).offset(3)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill

        changeImageButton.layer.cornerRadius = changeImageButton.frame.size.width / 2
        changeImageButton.layer.borderWidth = 3.0
        changeImageButton.layer.borderColor = UIColor.white.cgColor
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
