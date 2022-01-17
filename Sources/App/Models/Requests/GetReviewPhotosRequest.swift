//
//  GetReviewPhotos.swift
//  
//
//  Created by Denis Kuzmin on 17.01.2022.
//

import Vapor
import Foundation

struct GetReviewPhotosRequest: Content {
    let id: UUID
}
