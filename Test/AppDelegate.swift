//
//  AppDelegate.swift
//  Test
//
//  Created by Ashu Baweja on 20/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.updateRootController()
        return true
    }
}

extension AppDelegate{
    func updateRootController(){
        var navController: UINavigationController?

        if let _ = UserDefaultHelper.getToken() {
            let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebviewVC")
            navController = UINavigationController(rootViewController: webVC)
            window?.rootViewController = navController
        }
        else {
            let loginVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            navController = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navController
        }
        window?.makeKeyAndVisible()
    }
}
