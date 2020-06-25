//
//  GroupsResponse.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 22.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation
import RealmSwift

struct GroupsResponse: Decodable {
    let response: GroupsData
}

struct GroupsData: Decodable {
    let items: [Group]
    var count: Int
}

class Group: Object, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case avatar = "photo_50"
    }
    
}

