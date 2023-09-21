import SnapKit
import UIKit

class ProfileLabelViews: UIView {
    // 게시 라벨
    lazy var postNumberLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "0", textColor: .black, font: UIFont.systemFont(ofSize: 17))
        return label
    }()

    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "게시", textColor: .black, font: UIFont.systemFont(ofSize: 13))
        return label
    }()

    // 팔로우 숫자 라벨
    lazy var followerNumberLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "0", textColor: .black, font: UIFont.systemFont(ofSize: 17))
        return label
    }()

    // 팔로워 라벨
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "팔로워", textColor: .black, font: UIFont.systemFont(ofSize: 13))
        return label
    }()

    // 팔로잉 숫자 라벨
    lazy var followingNumberLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "0", textColor: .black, font: UIFont.systemFont(ofSize: 17))
        return label
    }()

    // 팔로잉 라벨
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "팔로잉", textColor: .black, font: UIFont.systemFont(ofSize: 13))
        return label
    }()

    //=============================================== STACK VIEW 시작 ======================================================

    // lazy란 만들어내는 그 시점에 메모리에 올리는 것 -> 순서를 위해 쓴다고 생각하면 편함
    lazy var postStackView: UIStackView = {
        let postStackView = UIStackView(arrangedSubviews: [postNumberLabel, postLabel])
        // 이 인스턴스들이 생성될때까지 기다렸다가 lazy var를 통해 메모리에 stackview를 한번에 메모리에 올린다
        postStackView.verticalStackView(spacing: 2)
        return postStackView
    }()

    // 팔로워 스택뷰
    lazy var followStackView: UIStackView = {
        let followStackView = UIStackView(arrangedSubviews: [followerNumberLabel, followerLabel])
        followStackView.verticalStackView(spacing: 2)
        return followStackView
    }()

    // 팔로잉 스택뷰
    lazy var followingStackView: UIStackView = {
        let followingStackView = UIStackView(arrangedSubviews: [followingNumberLabel, followingLabel])
        followingStackView.verticalStackView(spacing: 2)
        return followingStackView
    }()

    lazy var numberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postStackView, followStackView, followingStackView])
        stackView.horizontalStackView(spacing: 45)
        return stackView
    }()

    private func setupConstraints() {
        addSubview(numberStackView)
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-45)
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
