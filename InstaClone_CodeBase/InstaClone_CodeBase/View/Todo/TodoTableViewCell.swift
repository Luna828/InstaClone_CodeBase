import UIKit

class TodoTableViewCell: UITableViewCell {
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "MVVM 공부하기", textColor: .black, font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold))
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "2023-03-02", textColor: .darkGray, font: UIFont.systemFont(ofSize: 11))
        return label
    }()
    
    let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Label 추가
        contentView.addSubview(leftLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(toggleSwitch)
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dateLabel.trailingAnchor.constraint(equalTo: toggleSwitch.leadingAnchor, constant: -8),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
