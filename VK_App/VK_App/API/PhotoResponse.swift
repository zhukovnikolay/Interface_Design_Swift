//
//  PhotosResponse.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 22.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

struct PhotosResponse: Decodable {
    let response: PhotosData
}

struct PhotosData: Decodable {
    let items: [Photo]
}


class Photo: Decodable {
    
    dynamic var photo: String = ""
    
    enum CodingKeys: String, CodingKey {
        case photo = "photo_604"
    }
    
}
