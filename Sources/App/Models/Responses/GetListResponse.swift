//
//  GetListResponse.swift
//  
//
//  Created by Denis Kuzmin on 10.01.2022.
//

import Vapor

struct GetListResponse<T: Content>: Content {
    let result: Int
    let items: [T]?
    let errorMessage: String?
}
