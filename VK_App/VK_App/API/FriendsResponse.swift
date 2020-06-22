//
//  FriendsResponse.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 22.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

struct FriendsResponse: Decodable {
    let response: FriendsData
}

struct FriendsData: Decodable {
    let items: [User]
}


class User: Decodable {
    
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var avatar: String = ""
    dynamic var status: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
        case status = "online"
    }
    
}

