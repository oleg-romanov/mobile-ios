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
        AppDelegate.shared = self
        let firstController: UIViewController
        let vc: UIViewController
        if keychain.get(Keys.token) == nil {
            if UserDefaults.standard.bool(forKey: "isNotFirst") {
                let viewController = StartController()
                let presenter = StartPresenter(view: viewController)
                viewController.presenter = presenter
                firstController = viewController
                vc = UINavigationController(rootViewController: firstController)
                UserDefaults.standard.set(true, forKey: "isNotFIrst")
            } else {
                vc = OnboardingController()
            }
            window?.rootViewController = vc
        } else {
            // TODO: Показать экран с списком событий
        }
        window?.makeKeyAndVisible()
        return true
    }
}

