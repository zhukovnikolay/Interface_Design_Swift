//
//  AvatarUIView.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 17.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

@IBDesignable class AvatarUIView: UIView {
    
    let avatar = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatar)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(avatar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.frame = bounds
        avatar.layer.cornerRadius = avatar.frame.height / 2
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        avatar.layer.borderWidth = 2
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
    }
    
    @IBInspectable var shadowColor: UIColor = .lightGray {
        didSet {
            self.updateShadowColor()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 20.8 {
        didSet {
            self.updateShadowOpacity()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 3 {
        didSet {
            self.updateShadowRadius()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.updateShadowColor()
        }
    }
    

    func updateShadowColor() {
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    func updateShadowOpacity() {
        self.layer.shadowOpacity = shadowOpacity
    }

    func updateShadowRadius() {
        self.layer.shadowRadius = shadowRadius
    }

    func updateShadowOffset() {
        self.layer.shadowOffset = shadowOffset
    }
    
    
}
