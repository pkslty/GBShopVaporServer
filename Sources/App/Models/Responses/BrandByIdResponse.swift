//
//  BrandByIdResponse.swift
//  
//
//  Created by Denis Kuzmin on 13.01.2022.
//

import Vapor

struct BrandByIdResponse: Content {
    let result: Int
    let brand: Brand?
    let errorMessage: String?
}
