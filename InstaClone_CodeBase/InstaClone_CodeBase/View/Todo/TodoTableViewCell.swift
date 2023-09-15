//
//  TodoTableViewCell.swift
//  InstaClone_CodeBase
//
//  Created by t2023-m0050 on 2023/09/13.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    var titleLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // UITableViewCell에 포함될 UI 요소들을 생성하고 구성합니다.
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    // UITableViewCell에 데이터를 설정하는 메서드
//    func configure(with data: YourDataModel) {
//        titleLabel.text = data.title
//        // 다른 UI 요소도 설정 가능
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
