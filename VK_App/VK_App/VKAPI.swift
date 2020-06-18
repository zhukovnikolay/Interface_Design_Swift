//
//  VKAPI.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 17.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import Alamofire

class VKAPI {
    
    let vkURL = "https://api.vk.com/method/"
    
    func getFriendsInfo(token: String) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "order": "name",
            "fields": "city,domain"
        ]
        
        let requestURL = vkURL + "friends.get"
        AF.request(requestURL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            print(response.value ?? 0)
        })
    }
    
    func getPhotos(token: String, ownerId: String) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "owner_id": ownerId,
            "extended": "1",
            "photo_sizes": "1"
        ]
        
        let requestURL = vkURL + "photos.getAll"
        AF.request(requestURL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            print(response.value ?? 0)
        })
    }
    
    
    func getUserGroups(token: String, userId: String) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "user_id": userId,
            "extended": "1"
        ]
        
        let requestURL = vkURL + "groups.get"
        AF.request(requestURL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            print(response.value ?? 0)
        })
    }
    
    func groupSearch(token: String, query: String) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "q": query
        ]
        
        let requestURL = vkURL + "groups.search"
        AF.request(requestURL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
            print(response.value ?? 0)
        })
    }
    
}
