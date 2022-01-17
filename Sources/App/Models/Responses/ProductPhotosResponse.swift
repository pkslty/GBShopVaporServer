//
//  ProductPhotosResponse.swift
//  
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Vapor

struct ProductPhotosResponse: Content {
    let result: Int
    let photos: [ProductPhotoResponse]?
    let errorMessage: String?
}

struct ProductPhotoResponse: Content {
    let urlString: String
}
