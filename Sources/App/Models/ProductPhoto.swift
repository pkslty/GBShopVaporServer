//
//  ProductPhoto.swift
//  
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Fluent
import Vapor
import Foundation

final class ProductPhoto: Model, Content {
    
    
    static let schema = "product_photos"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "product_id") var productId: UUID
    @Field(key: "url_string") var urlString: String
    
    init() { }
    
    init(id: UUID, productId: UUID, urlString: String) {
        self.id = id
        self.productId = productId
        self.urlString = urlString
    }
}

