//
//  LoginViewController.swift
//  PersonalFinance
//
//  Created by Hristina Bailova on 11/19/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: CustomButton!
    
    var userService: UserService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.userServiceDelegate = self
        usernameTextField.transparency()
        passwordTextField.transparency()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage")!)
    }
    
    // Private methods
    private func checkForEmptyTextFields() {
        guard let username = usernameTextField.text,
            usernameTextField.text != "",
            let password = passwordTextField.text,
            passwordTextField.text != ""
            else {
                showAlert(title: "Missing credentials", message: "All fields must be filled in")
                return
        }
    }
    
    // Actions
    @IBAction func didPressLogin(_ sender: Any) {
        checkForEmptyTextFields()
        
        userService.loginUser(username: username, password: password)
    }
    
    @IBAction func didPressRegisterHereBtn(_ sender: Any) {
        print("Go to registration")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationVC = storyboard.instantiateViewController(withIdentifier: "\(RegisterViewController.self)") as? RegisterViewController
        self.present(registrationVC, animated: true, completion: nil)
    }
}

// MARK: - UserServiceDelegate
extension LoginViewController: UserServiceDelegate {
    func didRegisterSuccess(data: Data) {
        print("Logged in! Go to next VC.")
    }
    
    func didRegisterFailed(error: AnyObject) {
        DispatchQueue.main.async {
            self.showAlert(title: "Login failed", message: "Unable to log in with provided credentials.")
            print("Did not logged in!")
        }
    }
}
