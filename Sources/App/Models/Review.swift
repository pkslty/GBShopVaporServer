//
//  Review.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//
import Fluent
import Vapor

final class Review: Model, Content {
    
    
    static let schema = "reviews"
    
    @ID(custom: "id") var id: Int?
    @Field(key: "product_id") var productId: Int
    @Field(key: "user_id") var userId: Int
    @Field(key: "text") var text: String
    @Field(key: "rating") var rating: Int
    @Field(key: "likes") var likes: Int
    
    
    init() { }
    
    init(id: Int, productId: Int, userId: Int, text: String, rating: Int, likes: Int) {
        self.id = id
        self.productId = productId
        self.userId = userId
        self.text = text
        self.rating = rating
        self.likes = likes
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId
        case userId
        case text
        case rating
        case likes
    }
    
}

