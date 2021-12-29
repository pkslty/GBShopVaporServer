//
//  File.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//

import Vapor

struct LoginRequest: Content {
    let username: String
    let password: String
}
