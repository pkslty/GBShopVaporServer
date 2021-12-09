//
//  Crypto.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//

import Vapor

final class Crypto {
    static func MD5(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
