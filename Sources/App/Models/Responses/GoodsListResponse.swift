//
//  GoodsListResponse.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Vapor

struct GoodsListResponse: Content {
    let result: Int
    let pageNumber: Int?
    let products: [GoodsListItem]?
    let errorMessage: String?
}


