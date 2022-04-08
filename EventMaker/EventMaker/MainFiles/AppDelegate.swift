//
//  AppDelegate.swift
//  EventMaker
//
//  Created by Олег Романов on 30.03.2022.
//

import UIKit
import KeychainSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: AppDelegate?

    lazy var window: UIWindow? = UIWindow()

    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

