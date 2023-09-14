import UIKit
import SnapKit

class Header: UIView {
    private let profileImageView = ProfileImageViews()
    private let profileLabelView = ProfileLabelViews()

    // 전체 스택뷰
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, profileLabelView])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .horizontal

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Add the profileStackView to the Header view
        addSubview(profileStackView)

        // Set up constraints for the profileStackView
        profileStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Make the profileStackView cover the entire Header view
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("ERROR")
    }
}
