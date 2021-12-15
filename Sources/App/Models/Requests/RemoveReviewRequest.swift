//
//  RemoveReviewRequest.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor

struct RemoveReviewRequest: Content {
    let reviewId: Int
}
