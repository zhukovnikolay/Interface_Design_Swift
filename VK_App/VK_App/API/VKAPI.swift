//
//  VKAPI.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 17.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class VKAPI {
    
    let vkURL = "https://api.vk.com/method/"
    let realm = try! Realm()
    
    
//    func requestData(requestURL: String, parameters: [String: Any]) {
//        AF.request(requestURL, method: .post, parameters: parameters).responseData { (response) in
//            switch response.result {
//            case .failure(let error):
//                print(error)
//            case .success(let data):
//                do {
//                    let response = try JSONDecoder
//                }
//            }
//        }
//    }
    
    func getFriendsInfo(token: String, handler: @escaping (Result<[User], Error>) -> Void) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "order": "name",
            "fields": "photo_50,online"
        ]
        
        let requestURL = vkURL + "friends.get"
        
        AF.request(requestURL,
                   method: .post,
                   parameters: parameters)
            .responseData(completionHandler: { response in
            guard let data = response.data else { return }
            do {
                let friends = try JSONDecoder().decode(FriendsResponse.self, from: data)
                handler(.success(friends.response.items))
                self.saveFriends(friendsList: friends.response.items)
            } catch {
                handler(.failure(error))
            }
        })
    }
    
    func saveFriends(friendsList: [User]) {
        let realmUser = User()
        friendsList.forEach {
            realmUser.avatar = $0.avatar
            realmUser.firstName = $0.firstName
            realmUser.id = $0.id
            realmUser.lastName = $0.lastName
            realmUser.status = $0.status
        }
        try! realm.write {
            realm.add(realmUser)
        }
    }
    
    func saveGroups(groupsList: [Group]) {
        let realmGroup = Group()
        groupsList.forEach {
            realmGroup.avatar = $0.avatar
            realmGroup.name = $0.name
        }
        try! realm.write {
            realm.add(realmGroup)
        }
    }
    
    
    func getPhotos(token: String, ownerId: Int, handler: @escaping (Result<[Photo], Error>) -> Void) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "owner_id": ownerId,
            "extended": "1",
            "photo_sizes": "1",
            "count": "30"
        ]
        
        let requestURL = vkURL + "photos.getAll"
        AF.request(requestURL,
                   method: .post,
                   parameters: parameters)
            .responseData(completionHandler: { response in
            guard let data = response.value else { return }
            do {
                let photos = try JSONDecoder().decode(PhotosResponse.self, from: data)
                handler(.success(photos.response.items)) }
            catch {
                handler(.failure(error))
            }
        })
    }
    
    
    func getUserGroups(token: String, userId: String, handler: @escaping (Result<[Group], Error>) -> Void) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "user_id": userId,
            "extended": "1"
        ]
        
        let requestURL = vkURL + "groups.get"
        AF.request(requestURL,
                   method: .post,
                   parameters: parameters)
            .responseData(completionHandler: { response in
            guard let data = response.value else { return }
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                handler(.success(groups.response.items))
                self.saveGroups(groupsList: groups.response.items)
                print(self.realm.objects(Group.self))
            }
            catch {
                handler(.failure(error))
            }
        })
//        AF.request(requestURL, method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
//            print(response.value ?? 0)
//        })
    }
    
    func groupSearch(token: String, query: String, handler: @escaping (Result<[Group]?, Error>) -> Void) {
        
        let parameters: Parameters = [
            "v": "5.110",
            "access_token": token,
            "q": query
        ]
        
        let requestURL = vkURL + "groups.search"
        AF.request(requestURL,
                   method: .post,
                   parameters: parameters)
            .responseData(completionHandler: { response in
            guard let data = response.value else { return }
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                handler(.success(groups.response.items)) }
            catch {
                handler(.failure(error))
            }
        })
    }
    
}
