//
//  AddReviewRequest.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor
import Foundation

struct AddReviewRequest: Content {
    let productId: UUID
    let userId: UUID
    let text: String
    let rating: Int
}
