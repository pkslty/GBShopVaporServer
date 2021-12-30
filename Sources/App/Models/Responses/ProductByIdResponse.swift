//
//  GoodByIdResponse.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Foundation
import Vapor

struct ProductByIdResponse: Content {
    let result: Int
    let productName: String?
    let price: Double?
    let description: String?
    let errorMessage: String?
}
