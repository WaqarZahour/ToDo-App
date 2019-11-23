//
//  UIViewController+Extension.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 23/11/2019.
//  Copyright © 2019 Waqar Zahour. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// This function is used to show the alert
    /// - Parameters:
    ///   - title: title for Alert
    ///   - message: message for Alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: OKAY, style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController: ReusableIdentifier {}
