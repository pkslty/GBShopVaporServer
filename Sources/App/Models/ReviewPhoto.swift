//
//  ReviewPhoto.swift
//  
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Fluent
import Vapor
import Foundation

final class ReviewPhoto: Model, Content {
    
    
    static let schema = "review_photos"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "review_id") var reviewId: UUID
    @Field(key: "product_id") var productId: UUID
    @Field(key: "url_string") var urlString: String
    
    init() { }
    
    init(id: UUID, reviewId: UUID, productId: UUID, urlString: String) {
        self.id = id
        self.reviewId = reviewId
        self.productId = productId
        self.urlString = urlString
    }
}
