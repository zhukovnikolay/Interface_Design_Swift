//
//  GroupsTableViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 14.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class GroupsTableViewController: UITableViewController {

    var groups: [Group] = []
    @IBOutlet weak var searchGroups: UISearchBar!
    let vkAPI = VKAPI()
    
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//
//        // Проверяем идентификатор, чтобы убедиться, что это нужный переход
//        if segue.identifier == "addGroup" {
//        // Получаем ссылку на контроллер, с которого осуществлен переход
//            let source = segue.source as! AllGroupsTableViewController
//
//        // Получаем индекс выделенной ячейки
//            if let indexPath = source.tableView.indexPathForSelectedRow {
//        // Получаем группу по индексу
//                let group = source.groups[indexPath.row]
//        // Добавляем группу в список групп пользователя, если такой группы еще нет
//                if !groups.contains(group) {
//                        groups.append(group)
//                    // Обновляем таблицу
//                        tableView.reloadData()
//                }
//
//            }
//        }
//
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchGroups.delegate = self
        vkAPI.getUserGroups(token: Session.defaultSession.token, userId: Session.defaultSession.userId, handler: {result in
            switch result {
            case .success(let groups):
                self.groups = groups
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        cell.groupName.text = groups[indexPath.row].name
//        cell.groupAvatar.image = groups[indexPath.row].avatar
        cell.groupAvatar.af.setImage(withURL: URL(string: groups[indexPath.row].avatar)!)
        return cell
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        // Если была нажата кнопка «Удалить»
//        if editingStyle == .delete {
//        // Удаляем группу из массива
//            groups.remove(at: indexPath.row)
//        // И удаляем строку из таблицы
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

}

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            vkAPI.groupSearch(token: Session.defaultSession.token, query: searchText, handler: {result in
                switch result {
                case .success(let groups):
                    self.groups = groups!
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        } else {
            vkAPI.getUserGroups(token: Session.defaultSession.token, userId: Session.defaultSession.userId, handler: {result in
                switch result {
                case .success(let groups):
                    self.groups = groups
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
