//
//  Basket.swift
//  
//
//  Created by Denis Kuzmin on 16.12.2021.
//
import Fluent
import Vapor

final class Cart: Model, Content {
    
    
    static let schema = "Cart"
    
    @ID(custom: "id") var id: Int?
    @Field(key: "productId") var productId: Int
    @Field(key: "userId") var userId: Int
    @Field(key: "quantity") var quantity: Int
    
    
    init() { }
    
    init(id: Int, productId: Int, userId: Int, quantity: Int) {
        self.id = id
        self.productId = productId
        self.userId = userId
        self.quantity = quantity
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId
        case userId
        case quantity
    }
    
}
