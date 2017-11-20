//
//  UserService.swift
//  PersonalFinance
//
//  Created by Hristina Bailova on 11/20/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation

protocol UserServiceDelegate: class {
    func didRegisterSuccess(data: Data)
    func didRegisterFailed(error: AnyObject)
}

class UserService {
    var userServiceDelegate: UserServiceDelegate?
    
    init() {
        HttpRequester.sharedInstance.delegate = self
    }
    
    func loginUser(username: String, password: String) {
        let url = URL(string: APIURLs.loginUrl)
        let user = UserLogin(username: username, password: password)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(user)
        } catch {
            print("Error: \(error)")
        }
        
        HttpRequester.sharedInstance.requestJSON(withMethod: .post, toUrl: url, withBody: body)
    }
    
    func registerUser(username: String,
                      email: String,
                      password1: String,
                      password2: String) {
        let url = URL(string: APIURLs.registerUrl)
        let user = UserRegister(username: username, email: email, password1: password1, password2: password2)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(user)
        } catch {
            print("Error: \(error)")
        }
        
        HttpRequester.sharedInstance.requestJSON(withMethod: .post, toUrl: url, withBody: body)
    }
}

extension UserService: HttpRequesterDelegate {
    func didGetSuccess(data: Data) {
        
    }
    
    func didGetFailed(error: String) {
        
    }
    
    func didPostSuccess(data: Data) {
        userServiceDelegate?.didRegisterSuccess(data: data)
        print("Auth key")
    }
    
    func didPostFailed(error: String) {
        userServiceDelegate?.didRegisterFailed(error: error as AnyObject)
        print("Error!!: \(error)")
    }
}
