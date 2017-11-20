//
//  ViewControllerExtension.swift
//  PersonalFinance
//
//  Created by Hristina Bailova on 11/20/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
