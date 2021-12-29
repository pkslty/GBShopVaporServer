//
//  ServerController.swift
//  
//
//  Created by Denis Kuzmin on 25.12.2021.
//

import Vapor

class ServerController {
    func configureDatabase(_ req: Request, app: Application) throws -> String {
        guard let content = try? req.content.decode(ConfigureDatabaseRequest.self) else {
            throw Abort(.badRequest)
        }
        
        print(content)
        
        return ""
    }
}
