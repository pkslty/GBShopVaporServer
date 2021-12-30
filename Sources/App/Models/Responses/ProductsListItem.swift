//
//  GoodsListItem.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Vapor

struct ProductsListItem: Codable {
    let productId: Int
    let productName: String
    let price: Double
}
