//
//  RegisterController.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor

class UserController {
    func register(_ req: Request) throws -> EventLoopFuture<RegisterResponse> {
        guard let body = try? req.content.decode(User.self) else {
            throw Abort(.badRequest)
        }
            
        print(body)
        let users = User.query(on: req.db).all()
        let result: EventLoopFuture<RegisterResponse> = users.map { (users: [User]) -> RegisterResponse in
            let filtered = users.filter {($0.login == body.login) || ($0.email == body.email)}
            let lastId = users.sorted(by: {$0.id!  < $1.id!}).last?.id
            var response: RegisterResponse
            if filtered.count == 0 {
                response = RegisterResponse(
                    result: 1,
                    userMessage: "Регистрация прошла успешно!",
                    errorMessage: nil
                )
                body.id = lastId! + 1
                //body.makeMD5Password()
                body.create(on: req.db)
            }
            else {
                response = RegisterResponse(
                    result: 0,
                    userMessage: nil,
                    errorMessage: "Error: username or e-mail already exists"
                )
            }
            return response
        }
            
        return result
    }
    
}
