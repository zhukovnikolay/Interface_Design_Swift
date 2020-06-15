//
//  SessionClass.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 15.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit

class Session {
    
    static let defaultSession = Session()
    
    private init() { }
    
    var token: String = ""
    var userId: Int = 0
    
}
