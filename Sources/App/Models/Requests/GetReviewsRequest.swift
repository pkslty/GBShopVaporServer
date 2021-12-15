//
//  GetReviewsRequest.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor

struct GetReviewsRequest: Content {
    let productId: Int
}
