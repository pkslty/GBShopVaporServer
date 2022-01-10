//
//  GoodByIdRequest.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor
import Foundation

struct ProductByIdRequest: Content {
    let productId: UUID
}
