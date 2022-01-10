//
//  GoodsListREquest.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Vapor
import Foundation

struct ProductsListRequest: Content {
    let pageNumber: Int
    let categoryId: UUID
}
