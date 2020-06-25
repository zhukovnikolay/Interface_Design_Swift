//
//  FriendsTableViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 14.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct FriendsSection {
    var key: String
    var friends = [User]()
}

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchFriends: UISearchBar!
    
    var friends = [User]()
    var friendsSection = [FriendsSection]()
    var vkAPI = VKAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkAPI.getFriendsInfo(token: Session.defaultSession.token, handler: {result in
            switch result {
            case .success(let users):
                self.friends = users
                let friendsDict = Dictionary.init(grouping: self.friends){$0.lastName.prefix(1)}
                self.friendsSection = friendsDict.map { FriendsSection(key: String($0.key), friends: $0.value) }
                self.friendsSection.sort {$0.key < $1.key}
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
            
        searchFriends.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotos" else { return }
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let destination = segue.destination as! FriendsPhotosCollectionViewController
            destination.id = friendsSection[indexPath.section].friends[indexPath.row].id
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSection.map { $0.key }[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSection.map { $0.key }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsSection[section].friends.count
}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
            
        cell.friendName.text = friendsSection[indexPath.section].friends[indexPath.row].firstName + " " + friendsSection[indexPath.section].friends[indexPath.row].lastName

        cell.avatarView.avatar.af.setImage(withURL: URL(string: friendsSection[indexPath.section].friends[indexPath.row].avatar)!, placeholderImage: UIImage(systemName: "person.fill"))
        
        return cell
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchFriends.endEditing(true)
    }
        
}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredFriends = searchText.isEmpty ? friends : friends.filter({($0.lastName + $0.firstName).lowercased().contains(searchText.lowercased())})
        let friendsDict = Dictionary.init(grouping: filteredFriends){$0.lastName.prefix(1)}
        friendsSection = friendsDict.map { FriendsSection(key: String($0.key), friends: $0.value) }
        friendsSection.sort {$0.key < $1.key}
        tableView.reloadData()
}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFriends.endEditing(true)
    }
    
}
