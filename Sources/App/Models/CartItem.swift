//
//  CartItem.swift
//  
//
//  Created by Denis Kuzmin on 16.12.2021.
//
import Fluent
import Vapor

final class CartItem: Model, Content {
    
    
    static let schema = "cart"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "product_id") var productId: Int
    @Field(key: "user_id") var userId: Int
    @Field(key: "quantity") var quantity: Int
    
    
    init() { }
    
    init(id: UUID? = nil, productId: Int, userId: Int, quantity: Int) {
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
