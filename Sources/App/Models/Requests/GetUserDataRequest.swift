//
//  GetUserInfoRequest.swift
//  
//
//  Created by Denis Kuzmin on 24.12.2021.
//

import Vapor

struct GetUserDataRequest: Content {
    let token: String
}
