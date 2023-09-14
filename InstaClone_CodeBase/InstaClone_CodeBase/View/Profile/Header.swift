import SnapKit
import UIKit

class Header: UIView {
     let profileImageView = ProfileImageViews()
     let profileLabelView = ProfileLabelViews()

    // 전체 스택뷰
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, profileLabelView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    //스택뷰 밑의 라벨들 3개
    private var nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "김은경"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "iOS Developer🍎"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var websiteLabel: UILabel = {
        let label = UILabel()
        
        label.text = "https://github.com/Luna828"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, websiteLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 3
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(profileStackView)
        addSubview(labelStackView)

        profileStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //질문
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(30)
            make.top.equalTo(profileStackView.snp.top).offset(210)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("ERROR")
    }
}
