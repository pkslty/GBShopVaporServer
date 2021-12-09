//
//  LoggedUser.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//

import Foundation
import Fluent
import Vapor

final class LoggedUser: Model, Content {
    
    static let schema = "LoggedUsers"
    
    @ID(custom: "id") var id: Int?
    @Field(key: "token") var token: String
    
    init() { }
    
    init(id: Int, token: String) {
        self.id = id
        self.token = Crypto.MD5(String(id))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case token
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? values.decode(Int.self, forKey: .id)
        self.token = try values.decode(String.self, forKey: .token)
        
    }

    private func MD5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
