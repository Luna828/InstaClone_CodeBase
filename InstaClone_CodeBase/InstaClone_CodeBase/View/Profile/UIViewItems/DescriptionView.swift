import UIKit

final class DescriptionView: UIView {
    // 스택뷰 밑의 라벨들 3개
    var nameLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "김은경", textColor: .black, font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold))
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "iOS Developer🍎", textColor: .black, font: UIFont.systemFont(ofSize: 15))
        return label
    }()
    
    var websiteLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "https://github.com/Luna828", textColor: .blue, font: UIFont.systemFont(ofSize: 15))
        return label
    }()
    
    var followButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Follow"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var messageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Message"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "More"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
