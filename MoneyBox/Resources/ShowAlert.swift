//
//  ShowAlert.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit

    /// Error message organisation
class ShowAlert {
    static func popUp(title: String, message: String, inViewController viewController: UIViewController, completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        /// Colors in place in case dark mode active in settings
        alert.view.backgroundColor = UIColor(named: "GreyColor")
        alert.view.tintColor = UIColor(named: "AccentColor")
        
        /// Style similiar to Moneybox App
        let cancelAlert = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        
        /// Addition of cancel alert and access to viewController
        alert.addAction(cancelAlert)
        viewController.present(alert, animated: true, completion: nil)
    }
}
