//
//  ILikeIt.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 17.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class ILikeIt: UIControl {
    let likeButton = UIButton()
    let likeLabel = UILabel()
    var stackView = UIStackView()
    var likeCount = 0
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
//        likeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        likeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        likeButton.tintColor = .link
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        
        likeLabel.text = "\(likeCount)"
        likeLabel.textColor = .link
        
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(likeLabel)
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    @objc func likeAction() {
        likeButton.isSelected.toggle()
        likeButton.tintColor = likeButton.isSelected ? .red : .link
        likeLabel.textColor = likeButton.isSelected ? .red : .link
        if likeButton.isSelected {
            likeCount += 1
            UIView.transition(with: likeLabel, duration: 0.4, options: .transitionFlipFromBottom, animations: {
                self.likeLabel.text = "\(self.likeCount)"
            }, completion: nil)
            UIView.transition(with: likeButton, duration: 0.4, options: .transitionFlipFromLeft, animations: {}, completion: nil)
        } else {
            likeCount -= 1
            UIView.transition(with: likeLabel, duration: 0.4, options: .transitionFlipFromTop, animations: {
                self.likeLabel.text = "\(self.likeCount)"
            }, completion: nil)
            UIView.transition(with: likeButton, duration: 0.4, options: .transitionFlipFromRight, animations: {}, completion: nil)
        }
    }
    
}
