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
//    let realm = try! Realm()
    
    
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
                let friends = try JSONDecoder().decode(FriendsResponse.self, from: data).response.items
                handler(.success(friends))
                self.saveFriends(friendsList: friends)
            } catch {
                handler(.failure(error))
            }
        })
    }
    
    func saveFriends(friendsList: [User]) {
        do {
            let realm = try Realm()
            let oldValue = realm.objects(User.self)
            try realm.write {
                realm.delete(oldValue)
                realm.add(friendsList, update: .modified)
            }
        }
        catch {
            print (error)
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
                let photos = try JSONDecoder().decode(PhotosResponse.self, from: data).response.items
                handler(.success(photos))
                self.savePhotos(photoList: photos, userId: ownerId)
            }
            catch {
                handler(.failure(error))
            }
        })
    }
    
    func savePhotos(photoList: [Photo], userId: Int) {
        do {
            let realm = try Realm()
            let filter = "ownerId == " + String(userId)
            let oldValue = realm.objects(Photo.self).filter(filter)
            try realm.write {
                realm.delete(oldValue)
                realm.add(photoList, update: .modified)
            }
        }
        catch {
            print (error)
        }
    }
    
    func getUserGroups(token: String, userId: String, handler: @escaping (Result<[Group], Error>) -> Void) {
        
        let parameters: Parameters = [
            "v": "5.120",
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
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).response.items
                handler(.success(groups))
                self.saveGroups(groupsList: groups)
            }
            catch {
                handler(.failure(error))
            }
        })
    }
    
    func saveGroups(groupsList: [Group]) {
        do {
            let realm = try Realm()
            let oldValue = realm.objects(Group.self)
            try realm.write {
                realm.delete(oldValue)
                realm.add(groupsList, update: .modified)
            }
        }
        catch {
            print (error)
        }
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
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).response.items
                handler(.success(groups)) }
            catch {
                handler(.failure(error))
            }
        })
    }
    
}
