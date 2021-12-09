//
//  RegisterController.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor

class UserController {
    func register(_ req: Request) throws -> EventLoopFuture<RegisterResponse> {
        guard let body = try? req.content.decode(RegisterRequest.self) else {
            throw Abort(.badRequest)
        }
            
        print(body)
        let uu = User.query(on: req.db).all()
        let result: EventLoopFuture<RegisterResponse> = uu.map { (users: [User]) -> RegisterResponse in
            let filtered = users.filter {($0.login == body.username) || ($0.email == body.email)}
            var response: RegisterResponse
            if filtered.count == 0 {
                response = RegisterResponse(
                    result: 1,
                    userMessage: "Регистрация прошла успешно!",
                    errorMessage: nil
                )
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
