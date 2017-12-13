//
//  AppDelegate.swift
//  ios
//
//  Created by Ben Glynn on 04/12/2017.
//  Copyright © 2017 Just Eat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
        withTopmost(self.window!.rootViewController!) {
            let mask = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
            $0.present(mask, animated: false, completion: nil)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        withTopmost(self.window!.rootViewController!) {
            $0.dismiss(animated: false, completion: nil)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func withTopmost(_ viewController: UIViewController, _ callback: (_ viewController: UIViewController)->Void) {
        let presented = viewController.presentedViewController
        if(presented != nil) {
            withTopmost(presented!, callback)
        } else {
            callback(viewController)
        }
    }


}

