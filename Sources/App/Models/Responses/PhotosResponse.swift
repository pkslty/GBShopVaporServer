//
//  ProductPhotosResponse.swift
//  
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Vapor

struct PhotosResponse: Content {
    let result: Int
    let photos: [PhotoResponse]?
    let errorMessage: String?
}

struct PhotoResponse: Content {
    let urlString: String
}
