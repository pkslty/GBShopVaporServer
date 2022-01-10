//
//  RemoveFromCartRequest.swift
//  
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Vapor
import Foundation

struct RemoveFromCartRequest: Content {
    let productId: UUID
    let userId: UUID
    let quantity: Int?
}
