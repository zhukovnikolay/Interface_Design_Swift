//
//  AnimationViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 28.05.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        firstView.layer.cornerRadius = firstView.frame.width / 2
        secondView.layer.cornerRadius = secondView.frame.width / 2
        thirdView.layer.cornerRadius = thirdView.frame.width / 2
        
        UIView.animate(withDuration: 0.8, delay: 1, animations: {
                self.firstView.alpha = 0
            })
        
        UIView.animate(withDuration: 0.8, delay: 1.4, animations: {
                self.secondView.alpha = 0
            })
        
        UIView.animate(withDuration: 0.8, delay: 1.8, animations: {
            self.thirdView.alpha = 0
        }, completion: {
            (success) in self.performSegue(withIdentifier: "toLogin", sender: self)
        })

        // Do any additional setup after loading the view.
    }
    

}
