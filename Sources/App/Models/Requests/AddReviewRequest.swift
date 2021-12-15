//
//  AddReviewRequest.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor

struct AddReviewRequest: Content {
    let productId: Int
    let userId: Int
    let text: String
    let rating: Int
}
