//
//  RegisterResponse.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor

struct RegisterResponse: Content {
    var result: Int
    var userMessage: String?
    var errorMessage: String?
}
