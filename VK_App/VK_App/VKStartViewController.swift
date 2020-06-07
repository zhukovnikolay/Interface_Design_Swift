//
//  VKStartViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 01.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class VKStartViewController: UIViewController {

    @IBOutlet weak var vkLogo: VKLogoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkLogo.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0, delay: 0, animations: {
            self.vkLogo.alpha = 0
        }, completion: {
            (success) in self.performSegue(withIdentifier: "toLogin", sender: self)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
