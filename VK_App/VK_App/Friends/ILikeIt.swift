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
        likeButton.tintColor = .lightGray
        likeButton.addTarget(self, action: #selector(likeAction(_:)), for: .touchUpInside)
        
        likeLabel.text = "\(likeCount)"
        likeLabel.textColor = .lightGray
        
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
    
    @objc func likeAction(_ sender: UIButton) {
        likeButton.isSelected.toggle()
        likeButton.tintColor = likeButton.isSelected ? .red : .lightGray
        likeLabel.textColor = likeButton.isSelected ? .red : .lightGray
        likeCount = likeButton.isSelected ? likeCount + 1 : likeCount - 1
        likeLabel.text = "\(likeCount)"
    }
    
}
