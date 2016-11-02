//
//  AppDelegate.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/10/31.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()

        FIRAuth.auth()?.addStateDidChangeListener { _, user in
            if let _ = user {
//                SceneRouter.shared.route(scene: .main)
                SceneRouter.shared.route(scene: .registration)
            } else {
                SceneRouter.shared.route(scene: .registration)
            }
        }
        SceneRouter.shared.window = window

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
}
