//
//  GoodsListItem.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Vapor
import Foundation

struct ProductsListItem: Codable {
    let productId: UUID
    let productName: String
    let price: Double
}
