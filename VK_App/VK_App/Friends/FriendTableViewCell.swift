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
        UIView.animate(withDuration: 0.3, delay: 0, options: .autoreverse, animations: {
            self.avatarView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: {
            (success) in
            self.avatarView.transform = .identity
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
