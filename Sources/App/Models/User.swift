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
    @Field(key: "name") var name: String?
    @Field(key: "lastname") var lastname: String?
    @Field(key: "passwordMD5") var passwordMD5: String
    @Field(key: "email") var email: String
    @Field(key: "gender") var gender: String?
    @Field(key: "creditcard") var creditcard: String?
    @Field(key: "bio") var bio: String?
    
    init() { }
    
    init(id: Int, login: String, name: String, lastname: String, password: String, email: String, gender: String, creditcard: String, bio: String) {
        self.id = id
        self.login = login
        self.name = name
        self.lastname = lastname
        self.passwordMD5 = MD5(password)
        self.email = email
        self.gender = gender
        self.creditcard = creditcard
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
        case creditcard
        case bio
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? values.decode(Int.self, forKey: .id)
        self.login = try values.decode(String.self, forKey: .login)
        self.name = try? values.decode(String.self, forKey: .name)
        self.creditcard = try? values.decode(String.self, forKey: .creditcard)
        self.lastname = try? values.decode(String.self, forKey: .lastname)
        self.passwordMD5 = try values.decode(String.self, forKey: .password)
        self.email = try values.decode(String.self, forKey: .email)
        self.gender = try? values.decode(String.self, forKey: .gender)
        self.bio = try? values.decode(String.self, forKey: .bio)
        makeMD5Password()
    }

    private func MD5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    func makeMD5Password() {
        self.passwordMD5 = MD5(self.passwordMD5)
        //self.password = String()
    }
    
}

