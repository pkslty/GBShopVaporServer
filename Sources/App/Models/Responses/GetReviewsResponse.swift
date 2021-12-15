//
//  GetReviewsResponse.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor

struct GetReviewsResponse: Content {
    let result: Int
    let reviews: [Review]?
    let errorMessage: String?
}
