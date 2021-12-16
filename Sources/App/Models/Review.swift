//
//  Review.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//
import Fluent
import Vapor

final class Review: Model, Content {
    
    
    static let schema = "Reviews"
    
    @ID(custom: "id") var id: Int?
    @Field(key: "productId") var productId: Int
    @Field(key: "userId") var userId: Int
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

