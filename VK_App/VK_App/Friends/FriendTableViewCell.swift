//
//  FriendTableViewCell.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 14.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var avatarView: AvatarUIView!
    
    @objc func scaleAvatar() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.avatarView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: {
            (success) in
            UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
                self.avatarView.transform = .identity
            }, completion: nil)
        })
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapOnAvatar = UITapGestureRecognizer(target: self, action: #selector(scaleAvatar))
        avatarView.addGestureRecognizer(tapOnAvatar)
    }


    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    

}
