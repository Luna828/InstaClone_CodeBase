//
//  MainViewController.swift
//  ONigiry
//
//  Created by (^ㅗ^)7 iMac on 2023/09/11.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    let textButton: UIButton = {
        let button = UIButton()
        button.setTitle("TEST BUTTON", for: .normal)
        button.backgroundColor = UIColor.systemRed
        button.layer.cornerRadius = 10
        return button
    }()

    func setupUI() {
        view.addSubview(textButton)
        textButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
    }
}
