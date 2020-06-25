//
//  VKWebLoginViewController.swift
//  VK_App
//
//  Created by Nikolay Zhukov on 17.06.2020.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class WebLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let appId = "7514233"
    
    var urlComponents = URLComponents()
    
    let vkAPI = VKAPI()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: appId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)

    }
}

extension WebLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}.reduce([String : String]()) {
                value, parameters in
                var dict = value
                let key = parameters[0]
                let value = parameters[1]
                dict[key] = value
                return dict
        }
        
        Session.defaultSession.token = params["access_token"] ?? ""
        Session.defaultSession.userId = params["user_id"] ?? ""
        
        decisionHandler(.cancel)
        
        self.performSegue(withIdentifier: "toMainScreen", sender: self)
    }
}
