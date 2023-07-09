//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 15.01.2022.
//

import UIKit
import Networking

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let sessionManager = SessionManager()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Setting main window view
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginViewModel = LoginViewModel(sessionManager: sessionManager)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

