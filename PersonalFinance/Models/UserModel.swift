//
//  UserModel.swift
//  PersonalFinance
//
//  Created by Hristina Bailova on 11/19/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation

struct UserLogin: Codable {
    let username: String
    let password: String
}

struct UserRegister: Codable {
    let username: String
    let email: String
    let password1: String
    let password2: String
}
