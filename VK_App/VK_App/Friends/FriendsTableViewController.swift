//
//  FriendsTableViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 14.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

struct FriendsSection {
    var key: String
    var friends: [User]
}

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchFriends: UISearchBar!
    
    var friends: [User] = [User(firstName: "Василий", lastName: "Марцыпанов", avatar:       UIImage(named: "VasiliyAvatar")!, photos: [UIImage(named: "VasiliyPhoto")!, UIImage(named: "VasiliyAvatar")!]),
                           User(firstName: "Снежана", lastName: "Денисова", avatar: UIImage(named: "SnezhanaAvatar")!, photos: [UIImage(named: "SnezhanaPhoto")!, UIImage(named: "SnezhanaPhoto2")!]),
                            User(firstName: "Lucas", lastName: "Rin", avatar: UIImage(named: "LucasAvatar")!, photos: [UIImage(named: "LucasPhoto1")!, UIImage(named: "LucasPhoto2")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!]),
                            User(firstName: "Ксения", lastName: "Морковкина", avatar: UIImage(named: "KseniaAvatar")!, photos: [UIImage(named: "KseniaPhoto1")!, UIImage(named: "KseniaPhoto2")!, UIImage(named: "KseniaPhoto3")!])]
    
    var friendsSection = [FriendsSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendsDict = Dictionary.init(grouping: friends){$0.lastName.prefix(1)}
        friendsSection = friendsDict.map { FriendsSection(key: String($0.key), friends: $0.value) }
        friendsSection.sort {$0.key < $1.key}
        searchFriends.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotos" else { return }
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let destination = segue.destination as! FriendsPhotosCollectionViewController
            destination.photos = friendsSection[indexPath.section].friends[indexPath.row].photos
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
        cell.avatarView.avatar.image = friendsSection[indexPath.section].friends[indexPath.row].avatar
        return cell
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
}
