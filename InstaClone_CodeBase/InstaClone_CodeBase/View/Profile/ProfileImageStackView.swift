import SnapKit
import UIKit

final class ProfileImageStackView: UIView {
    // 프로필 이미지 뷰
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "moomin")
        //imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        //imageView.layer.cornerRadius = imageView.frame.width / 2
        //print(imageView.frame.width
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        changeImageButton.layer.cornerRadius = changeImageButton.frame.size.width / 2
        changeImageButton.layer.borderWidth = 3.0
        changeImageButton.layer.borderColor = UIColor.white.cgColor
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
    private lazy var changeImageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.tintColor = .systemBlue
        btn.clipsToBounds = true
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 80)

        return btn
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김은경"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints(){
        addSubview(profileImageView)
        addSubview(changeImageButton)
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.width.height.equalTo(80)
        }

        changeImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(50)
            make.trailing.equalTo(profileImageView.snp.trailing).offset(3)
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
