import SnapKit
import UIKit

class ProfileLabelViews: UIView {

    private lazy var postNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)

        return label
    }()

    // 게시글 라벨
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "게시"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    // 팔로우 숫자 라벨
    private lazy var followerNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)

        return label
    }()

    // 팔로워 라벨
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "팔로워"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    // 팔로잉 숫자 라벨
    private lazy var followingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)

        return label
    }()

    // 팔로잉 라벨
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "팔로잉"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    // 게시글 스택뷰
    // lazy란 만들어내는 그 시점에 메모리에 올리는 것 -> 순서를 위해 쓴다고 생각하면 편함
    lazy var postStackView: UIStackView = {
        let postStackView = UIStackView(arrangedSubviews: [
            postNumberLabel, // 이 인스턴스들이 생성될때까지 기다렸다가 lazy var를 통해 메모리에 stackview를 한번에 메모리에 올린다
            postLabel
        ])
        postStackView.translatesAutoresizingMaskIntoConstraints = false

        postStackView.alignment = .center
        postStackView.axis = .vertical
        postStackView.spacing = 2

        return postStackView
    }()

    // 팔로워 스택뷰
    lazy var followStackView: UIStackView = {
        let followStackView = UIStackView(arrangedSubviews: [
            followerNumberLabel,
            followerLabel
        ])
        followStackView.translatesAutoresizingMaskIntoConstraints = false

        followStackView.alignment = .center
        followStackView.axis = .vertical
        followStackView.spacing = 2

        return followStackView
    }()

    // 팔로잉 스택뷰
    lazy var followingStackView: UIStackView = {
        let followingStackView = UIStackView(arrangedSubviews: [
            followingNumberLabel,
            followingLabel
        ])
        followingStackView.translatesAutoresizingMaskIntoConstraints = false

        followingStackView.alignment = .center
        followingStackView.axis = .vertical
        followingStackView.spacing = 2

        return followingStackView
    }()

    lazy var numberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            postStackView,
            followStackView,
            followingStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .horizontal
        stackView.spacing = 45

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
