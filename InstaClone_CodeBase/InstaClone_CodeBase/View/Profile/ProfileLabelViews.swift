//
//  ProfileLabelView.swift
//  InstaClone_CodeBase
//
//  Created by t2023-m0050 on 2023/09/14.
//

import UIKit
import SnapKit

class ProfileLabelViews: UIView {
    var postNumberLabel: UILabel = {
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
    private lazy var postStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postNumberLabel, postLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2

        return stackView
    }()

    // 팔로워 스택뷰
    private lazy var followStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followerNumberLabel, followerLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2

        return stackView
    }()

    // 팔로잉 스택뷰
    private lazy var followingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingNumberLabel, followingLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 2

        return stackView
    }()

    private lazy var profileStackView: UIStackView = {
        let profileImageViews = ProfileImageViews()
        let stackView = UIStackView(arrangedSubviews: [profileImageViews, numberStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 50

        return stackView
    }()

    private lazy var numberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postStackView, followStackView, followingStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .horizontal
        stackView.spacing = 45

        return stackView
    }()

    private func setupConstraints() {
        addSubview(profileStackView)

        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
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
