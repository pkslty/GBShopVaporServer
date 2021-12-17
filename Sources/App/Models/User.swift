//
//  User.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Fluent
import Vapor

final class User: Model, Content {
    
    static let schema = "users"
    
    @ID(custom: "id") var id: Int?
    @Field(key: "login") var login: String
    @Field(key: "name") var name: String?
    @Field(key: "lastname") var lastname: String?
    @Field(key: "password_md5") var passwordMD5: String
    @Field(key: "email") var email: String
    @Field(key: "gender") var gender: String?
    @Field(key: "credit_card") var creditCard: String?
    @Field(key: "bio") var bio: String?
    @Field(key: "token") var token: String?
    
    init() { }
    
    init(id: Int, login: String, name: String, lastname: String, password: String, email: String, gender: String, creditCard: String, bio: String) {
        self.id = id
        self.login = login
        self.name = name
        self.lastname = lastname
        self.passwordMD5 = Crypto.MD5(password)
        self.email = email
        self.gender = gender
        self.creditCard = creditCard
        self.bio = bio
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case lastname
        case password
        case email
        case gender
        case creditCard
        case bio
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? values.decode(Int.self, forKey: .id)
        self.login = try values.decode(String.self, forKey: .login)
        self.name = try? values.decode(String.self, forKey: .name)
        self.creditCard = try? values.decode(String.self, forKey: .creditCard)
        self.lastname = try? values.decode(String.self, forKey: .lastname)
        self.passwordMD5 = try values.decode(String.self, forKey: .password)
        self.email = try values.decode(String.self, forKey: .email)
        self.gender = try? values.decode(String.self, forKey: .gender)
        self.bio = try? values.decode(String.self, forKey: .bio)
        self.passwordMD5 = Crypto.MD5(self.passwordMD5)
    }
    
}

