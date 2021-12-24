//
//  RegisterController.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor
import FluentPostgresDriver

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
    
    func getUserInfo(_ req: Request) throws -> EventLoopFuture<LoginResponse> {
        guard let body = try? req.content.decode(GetUserDataRequest.self) else {
            throw Abort(.badRequest)
        }
        
        print(body)
        
        let users = User.query(on: req.db)
            .filter(\.$token == body.token)
            .all()
        let result: EventLoopFuture<LoginResponse> = users.map { (users: [User]) -> LoginResponse in
            guard users.count == 1 else {
                return LoginResponse(
                            result: 0,
                            user: nil,
                            token: body.token,
                            errorMessage: "More than one user for token"
                )
            }
            var response: LoginResponse
            let user = users[0]
            response = LoginResponse(result: 1,
                                     user: UserData(id: user.id!,
                                                    login: user.login,
                                                    name: user.name,
                                                    lastname: user.lastname,
                                                    email: user.email,
                                                    gender: user.gender,
                                                    creditCard: user.creditCard,
                                                    bio: user.bio),
                                     token: user.token,
                                     errorMessage: nil)
            return response
        }
            
        return result
    }
    
}
