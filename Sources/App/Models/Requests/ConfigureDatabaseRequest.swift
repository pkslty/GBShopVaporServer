//
//  ConfigureDatabaseRequest.swift
//  
//
//  Created by Denis Kuzmin on 25.12.2021.
//

import Vapor

struct ConfigureDatabaseRequest: Content {
    let databaseHostname: String
    let database: String
    let databaseUsername: String
    let databasePassword: String
}
