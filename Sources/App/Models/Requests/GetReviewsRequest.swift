//
//  GetReviewsRequest.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor
import Foundation

struct GetReviewsRequest: Content {
    let productId: UUID
}
