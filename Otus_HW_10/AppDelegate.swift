//
//  AppDelegate.swift
//  Otus_HW_1
//
//  Created by alex on 02/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }


}

extension AppDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let storyboard = UIStoryboard(name: "ShareExtensionStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShareExtensionViewController")

        if let rootViewController = self.window?.rootViewController {
            if let shareExtensionController  = vc as? ShareExtensionViewController {
                if let ud = UserDefaults(suiteName: "group.OtusHW.OtusShare") {
                    if  let text = ud.string(forKey: "text"){
                        shareExtensionController.text = text
                    }
                }
            }
            rootViewController.present(vc, animated: false, completion: nil)
            return true
        }
        return false
    }
    
}
