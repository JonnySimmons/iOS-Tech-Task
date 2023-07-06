//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 15.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    var accountViewController: AccountViewController?
    var productViewController: IndividualAccountViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Setting main window view
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginViewController = LoginViewController()
        navigationController = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

