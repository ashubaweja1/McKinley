//
//  UserDefaultHelper.swift
//  Test
//
//  Created by Ashu Baweja on 20/05/20.
//  Copyright © 2020 Ashu Baweja. All rights reserved.
//

import Foundation

class UserDefaultHelper {
    
    class func set(_ value : Any?, forkey key : String) {
        if let value = value {
            UserDefaults.standard.set(value, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    class func get(_ key : String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func setToken(token: String) {
        UserDefaultHelper.set(token, forkey: kToken)
    }
    
    class func getToken() -> String? {
       return (UserDefaultHelper.get(kToken) as? String)
    }
}
