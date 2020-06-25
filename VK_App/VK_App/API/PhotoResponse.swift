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
    
    dynamic var sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
    
}

class Size: Object, Decodable {
        @objc dynamic var type: String
        @objc dynamic var url: String
}
