//
//  RegisterController.swift
//  
//
//  Created by Denis Kuzmin on 08.12.2021.
//

import Vapor
import FluentPostgresDriver
import Foundation

class UserController {
    func register(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(User.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        
        
        let result: EventLoopFuture<CommonResponse> =
        User.query(on: req.db)
            .group(.or) {
                $0.filter(\.$username == body.username).filter(\.$email == body.email)
            }
            .all()
            .map { (users: [User]) -> CommonResponse in
            var response: CommonResponse
            if users.count == 0 {
                response = CommonResponse(
                    result: 1,
                    userMessage: "Succesfully register!",
                    errorMessage: nil
                )
                body.id = UUID()
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
        print("Request:")
        print(body)
        
        let result: EventLoopFuture<CommonResponse> =
        User.query(on: req.db)
            .group(.or) {
                $0.filter(\.$token == body.token).filter(\.$username == body.username).filter(\.$email == body.email)
            }
            .all()
            .map { (users: [User]) -> CommonResponse in
                if users.count == 0 {
                    let response = CommonResponse(
                        result: 0,
                        userMessage: nil,
                        errorMessage: "No such user"
                    )
                    
                    print("Response:\n\(response)")
                    return response
                }
                if users.count > 1 {
                    let response = CommonResponse(
                        result: 0,
                        userMessage: nil,
                        errorMessage: "username or email already exists"
                    )
                    
                    print("Response:\n\(response)")
                    return response
                }
                let user = users[0]
                var response: CommonResponse
                response = CommonResponse(
                    result: 1,
                    userMessage: "Succesfully changed user data!",
                    errorMessage: nil
                )
                user.bio = body.bio
                user.gender = body.gender
                user.email = body.email
                user.name = body.name
                user.middleName = body.middleName
                user.lastName = body.lastName
                user.photoUrlString = body.photoUrlString
                user.passwordHash = body.passwordHash == nil ? user.passwordHash : body.passwordHash
                let _ = user.update(on: req.db)
                
                print("Response:\n \(response)")
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
                            errorMessage: "More than one user for token"
                )
            }
            var response: LoginResponse
            let user = users[0]
            user.passwordHash = String()
            response = LoginResponse(result: 1,
                                     user: user,
                                     errorMessage: nil)
            return response
        }
            
        return result
    }
    
}
