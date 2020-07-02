//
//  PhotosResponse.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 22.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation
import RealmSwift

struct PhotosResponse: Decodable {
    let response: PhotosData
}

struct PhotosData: Decodable {
    let items: [Photo]
}


class Photo: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var albumId: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case sizes
        case albumId = "album_id"
        case ownerId = "owner_id"
        case id
    }
    
    enum CodingKeysPhotoSizes: String, CodingKey {
        case type
        case url
    }
    
    override class func primaryKey() -> String? {
        "url"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.albumId = try values.decode(Int.self, forKey: .albumId)
        self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        
        var photoSizeValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        
        while !photoSizeValues.isAtEnd {
            let size = try photoSizeValues.nestedContainer(keyedBy: CodingKeysPhotoSizes.self)
            let sizeType = try size.decode(String.self, forKey: .type)
            switch sizeType {
            case "y":
                self.url = try size.decode(String.self, forKey: .url)
//            case "w":
//                self.urlHighQuality = try size.decode(String.self, forKey: .url)
            default:
                break
            }
        }
    }
    
}

//class Size: Object, Decodable {
//        @objc dynamic var type: String
//        @objc dynamic var url: String
//}
