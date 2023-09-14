//
//  discriptionView.swift
//  InstaClone_CodeBase
//
//  Created by t2023-m0050 on 2023/09/15.
//

import UIKit

class DescriptionView: UIView {
    // 스택뷰 밑의 라벨들 3개
    var nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "김은경"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "iOS Developer🍎"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var websiteLabel: UILabel = {
        let label = UILabel()
        
        label.text = "https://github.com/Luna828"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
