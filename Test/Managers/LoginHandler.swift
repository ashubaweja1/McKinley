//
//  LoginHandler.swift
//  Test
//
//  Created by Ashu Baweja on 20/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import Foundation
import UIKit

// MARK: Api Related Methods
class LoginHandler {
    
    /// This method will fetch the user list from server
    /// - Parameter completionHandler: return user list or error
    class func hitLoginApi(params: [String: String], completionHandler: ((String?, _ error : Error?) -> Void)? = nil) {
        
        NetworkManager.sendRequest(requestUrl: kLoginUrl, type: .Post, params: params) { (json, error) in
            var token: String?
            if let tokenJson = json as? [String: String] {
                if let apiToken = tokenJson[kToken]{
                    token = apiToken
                }
            }
            completionHandler?(token, error)
        }
    }
}




