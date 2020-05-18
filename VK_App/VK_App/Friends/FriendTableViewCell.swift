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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    

}
