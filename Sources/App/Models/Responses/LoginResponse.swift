//
//  LoginResponse.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//

import Vapor

struct LoginResponse: Content {
    let result: Int
    let user: UserData?
    let token: String?
    let errorMessage: String?
}

struct UserData: Content {
    let id: Int
    let login: String
    let name: String?
    let lastname: String?
    let email: String
    let gender: String?
    let creditcard: String?
    let bio: String?
}
