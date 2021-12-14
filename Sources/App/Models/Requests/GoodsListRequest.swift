//
//  GoodsListREquest.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Vapor

struct GoodsListRequest: Content {
    let pageNumber: Int
    let categoryId: Int
}
