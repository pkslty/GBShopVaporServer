//
//  Product.swift
//  
//
//  Created by Denis Kuzmin on 14.12.2021.
//

import Fluent
import Vapor
import Foundation

final class Product: Model, Content {
    
    
    static let schema = "products"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "product_name") var productName: String
    @Field(key: "product_description") var productDescription: String
    @Field(key: "category_id") var categoryId: UUID
    @Field(key: "brand_id") var brandId: UUID
    @Field(key: "price") var price: Double
    @Field(key: "discount") var discount: Double
    @Field(key: "quantity") var quantity: Int
    @Field(key: "reserv") var reserv: Int
    @Field(key: "rating") var rating: Int
    
    init() { }
    
    init(productId: UUID, productName: String, productDescription: String, categoryId: UUID, brandId: UUID, price: Double, discount: Double, quantity: Int, reserv: Int, rating: Int) {
        self.id = productId
        self.productName = productName
        self.productDescription = productDescription
        self.categoryId = categoryId
        self.brandId = brandId
        self.price = price
        self.discount = discount
        self.quantity = quantity
        self.reserv = reserv
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case productName
        case productDescription
        case categoryId
        case brandId
        case price
        case discount
        case quantity
        case reserv
        case rating
    }
    
}

