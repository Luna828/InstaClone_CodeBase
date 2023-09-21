import SnapKit
import UIKit

final class ProfileImageViews: UIView {
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
    
    // + 버튼
    lazy var changeImageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.customeButton(
            tintColor: .systemBlue,
            clipsToBounds: true,
            frame: CGRect(x: 0, y: 0, width: 80, height: 80)
        )
        return btn
    }()
//======================================== 함수 및 AutoLayout 구현 ========================================
    
    private func setupConstraints() {
        addSubview(profileImageView)
        addSubview(changeImageButton)

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
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
