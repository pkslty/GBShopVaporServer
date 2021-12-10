//
//  RegisterController.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor

class UserController {
    func register(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(User.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        let users = User.query(on: req.db).all()
        let result: EventLoopFuture<CommonResponse> = users.map { (users: [User]) -> CommonResponse in
            let filtered = users.filter {($0.login == body.login) || ($0.email == body.email)}
            var response: CommonResponse
            if filtered.count == 0 {
                response = CommonResponse(
                    result: 1,
                    userMessage: "Регистрация прошла успешно!",
                    errorMessage: nil
                )
                body.id = users.count + 1
                let _ = body.create(on: req.db)
            }
            else {
                response = CommonResponse(
                    result: 0,
                    userMessage: nil,
                    errorMessage: "Error: username or e-mail already exists"
                )
            }
            print(response)
            return response
        }
            
        return result
    }
    
    func changeUserData(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(User.self) else {
            throw Abort(.badRequest)
        }
        let users = User.query(on: req.db).all()
        let result: EventLoopFuture<CommonResponse> = users.map { (users: [User]) -> CommonResponse in
            guard let user = users.first(where: { $0.id == body.id }) else {
                return CommonResponse(
                    result: 0,
                    userMessage: nil,
                    errorMessage: "No such user"
                )
            }
            let filtered = users.filter {($0.login == body.login) || ($0.email == body.email)}
            var response: CommonResponse
            if filtered.count == 1 && filtered[0].id == body.id {
                response = CommonResponse(
                    result: 1,
                    userMessage: "Succesfully changed user data!",
                    errorMessage: nil
                )
                user.creditCard = body.creditCard
                user.bio = body.bio
                user.gender = body.gender
                user.email = body.email
                user.name = body.name
                user.lastname = body.lastname
                let _ = user.update(on: req.db)
            }
            else {
                response = CommonResponse(
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
