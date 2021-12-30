//
//  GoodsListResponse.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Vapor

struct ProductsListResponse: Content {
    let result: Int
    let pageNumber: Int?
    let products: [ProductsListItem]?
    let errorMessage: String?
}


