//
//  WebviewVC.swift
//  Test
//
//  Created by Ashu Baweja on 20/05/20.
//  Copyright © 2020 Ashu Baweja. All rights reserved.
//

import UIKit

class WebviewVC: UIViewController {
    @IBOutlet weak var detailWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = UserDefaultHelper.getToken() {
            let urlString = kTokenUrl + token
            if let url = URL(string:urlString) {
                let urlRequest = URLRequest(url: url)
                detailWebView.loadRequest(urlRequest)
            }
        }
    }
}

extension WebviewVC: UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finished loading")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("failed with error \(error)")
    }
    
}
