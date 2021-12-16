//
//  RemoveFromCartRequest.swift
//  
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Vapor

struct RemoveFromCartRequest: Content {
    let productId: Int
    let userId: Int
    let quantity: Int?
}
