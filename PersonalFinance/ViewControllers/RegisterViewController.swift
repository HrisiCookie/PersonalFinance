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
    }
    
    // Private methods    
    private func checkForEmptyTextFields() {
        guard let username = usernameTextField.text,
            usernameTextField.text != "",
            email = emailTextFielld.text,
            emailTextFielld.text != "",
            let password = passwordTextField.text,
            passwordTextField.text != "" else {return}
    }
    
    // Actions
    @IBAction func didPressRegister(_ sender: Any) {
        checkForEmptyTextFields()
        
        userService.registerUser(username: usernameTextField.text!, email: emailTextFielld.text!, password1: passwordTextField.text!, password2: passwordTextField.text!)
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
