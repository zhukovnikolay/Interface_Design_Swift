//
//  NewsTableViewCell.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 24.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatar: AvatarUIView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeControl: ILikeIt!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
