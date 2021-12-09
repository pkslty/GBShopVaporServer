//
//  User.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Foundation
import Fluent
import Vapor

final class User: Model, Content {
    
    static let schema = "Users"
    
    @ID(custom: "id") var id: Int?
    @Field(key: "login") var login: String
    @Field(key: "name") var name: String
    @Field(key: "lastname") var lastname: String
    @Field(key: "password") var password: String
    @Field(key: "email") var email: String
    @Field(key: "gender") var gender: String
    @Field(key: "creditcard") var creditcard: String
    @Field(key: "bio") var bio: String
    
    init() { }
    
    init(id: Int, login: String, name: String, lastname: String, password: String, email: String, gender: String, creditcard: String, bio: String) {
        self.id = id
        self.login = login
        self.name = name
        self.lastname = lastname
        self.password = password
        self.email = email
        self.gender = gender
        self.creditcard = creditcard
        self.bio = bio
    }

}

