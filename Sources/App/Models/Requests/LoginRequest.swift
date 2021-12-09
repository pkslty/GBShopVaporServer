//
//  File.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//

import Vapor

struct LoginRequest: Content {
    let login: String
    let password: String
}
