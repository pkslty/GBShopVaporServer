//
//  RegisterResponse.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor

struct UserResponse: Content {
    var result: Int
    var userMessage: String?
    var errorMessage: String?
}
