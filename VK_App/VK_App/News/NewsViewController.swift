//
//  NewsViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 24.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var news: [News] = [News(fullName: "Василий Марцыпанов", time: "сегодня в 8:25", newsText: "Привет всем!", avatar: UIImage(named: "VasiliyAvatar")!, newsImage: UIImage(named: "VasiliyPhoto")!), News(fullName: "Sport", time: "вчера в 16:23", newsText: "Приглашаем всех на занятия в наш новый спортивный клуб недалеко от метро Динамо.\nУ нас отличный огромный бассейн!\nПервым пяти клиентам индивидуальная тренировка в подарок!", avatar: UIImage(named: "sport")!, newsImage: UIImage(named: "sport")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        cell.avatar.avatar.image = news[indexPath.row].avatar
        cell.fullname.text = news[indexPath.row].fullName
        cell.newsText.text = news[indexPath.row].newsText
        cell.time.text = news[indexPath.row].time
        cell.newsImage.image = news[indexPath.row].newsImage
            
        return cell
    }
    
    
}

