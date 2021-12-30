//
//  LoginResponse.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//

import Vapor

struct LoginResponse: Content {
    let result: Int
    let user: User?
    let errorMessage: String?
}

