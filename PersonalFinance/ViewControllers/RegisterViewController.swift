//
//  RegisterViewController.swift
//  PersonalFinance
//
//  Created by Hristina Bailova on 11/20/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextFielld: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userService: UserService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.userServiceDelegate = self
        
        guard let image = UIImage(named: "backgroundImage") else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    // Actions
    @IBAction func didPressRegister(_ sender: Any) {
        guard let username = usernameTextField.text,
            usernameTextField.text != "",
            let email = emailTextFielld.text,
            emailTextFielld.text != "",
            let password = passwordTextField.text,
            passwordTextField.text != "" else {return}
        
        userService.registerUser(username: username, email: email, password1: password, password2: password)
    }
    
    @IBAction func didPressGoToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UserServiceDelegate
extension RegisterViewController: UserServiceDelegate {
    func didRegisterSuccess(data: Data) {
        print("Registered! Go to next VC")
    }
    
    func didRegisterFailed(error: AnyObject) {
        print("Error!!")
    }
    
    
}
