//
//  PayCartRequest.swift
//  
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Vapor
import Foundation

struct PayCartRequest: Content {
    let userId: UUID
}
