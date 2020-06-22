//
//  GroupsResponse.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 22.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

struct GroupsResponse: Decodable {
    let response: GroupsData
}

struct GroupsData: Decodable {
    let items: [Group]
}

class Group: Decodable {
    
    dynamic var name: String = ""
    dynamic var membersCount: Int = 0
    dynamic var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case membersCount = "members_count"
        case avatar = "photo_50"
    }
    
}

