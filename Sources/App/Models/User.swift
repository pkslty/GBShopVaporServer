//
//  User.swift
//  
//
//  Created by Denis Kuzmin on 29.12.2021.
//

import Fluent
import Vapor
import Foundation

final class User: Model, Content {
    
    static let schema = "users"
    
    @ID(key: .id) var id: UUID?
    @Field(key: "username") var username: String
    @Field(key: "name") var name: String?
    @Field(key: "middle_name") var middleName: String?
    @Field(key: "last_name") var lastName: String?
    @Field(key: "password_hash") var passwordHash: String?
    @Field(key: "email") var email: String
    @Field(key: "gender") var gender: String?
    @Field(key: "credit_card_id") var creditCardId: UUID?
    @Field(key: "bio") var bio: String?
    @Field(key: "token") var token: String?
    @Field(key: "photo") var photoUrlString: String?
    
    init() { }
    
    init(id: UUID, username: String, password: String, name: String, middleName: String, lastName: String, email: String, gender: String, bio: String) {
        self.id = id
        self.username = username
        self.name = name
        self.lastName = lastName
        self.passwordHash = Crypto.MD5(password)
        self.email = email
        self.gender = gender
        self.bio = bio
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case middleName
        case lastName
        case passwordHash = "password"
        case email
        case gender
        case bio
        case token
        case photoUrlString
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? values.decode(UUID.self, forKey: .id)
        self.username = try values.decode(String.self, forKey: .username)
        self.name = try? values.decode(String.self, forKey: .name)
        self.middleName = try? values.decode(String.self, forKey: .middleName)
        self.lastName = try? values.decode(String.self, forKey: .lastName)
        self.passwordHash = try? values.decode(String.self, forKey: .passwordHash)
        self.email = try values.decode(String.self, forKey: .email)
        self.gender = try? values.decode(String.self, forKey: .gender)
        self.bio = try? values.decode(String.self, forKey: .bio)
        if let passwordHash = self.passwordHash {
            self.passwordHash = Crypto.MD5(passwordHash)
        }
        self.token = try? values.decode(String.self, forKey: .token)
        self.photoUrlString = try? values.decode(String.self, forKey: .photoUrlString)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(name, forKey: .name)
        try container.encode(middleName, forKey: .middleName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(passwordHash, forKey: .passwordHash)
        try container.encode(email, forKey: .email)
        try container.encode(gender, forKey: .gender)
        try container.encode(bio, forKey: .bio)
        try container.encode(token, forKey: .token)
        try container.encode(photoUrlString, forKey: .photoUrlString)
        
            
        }
    
}
