//
//  CAtegory.swift
//  
//
//  Created by Denis Kuzmin on 10.01.2022.
//

import Fluent
import Vapor
import Foundation

final class Category: Model, Content {
    
    
    static let schema = "categories"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "description") var description: String
    
    init() { }
    
    init(id: UUID, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    
}
