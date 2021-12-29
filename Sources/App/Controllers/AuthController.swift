//
//  Auth.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//
import Vapor
import FluentPostgresDriver

class AuthController {
    func login(_ req: Request) throws -> EventLoopFuture<LoginResponse> {
        guard let body = try? req.content.decode(LoginRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        let users = User.query(on: req.db).all()
        let result: EventLoopFuture<LoginResponse> = users.map { (users: [User]) -> LoginResponse in
            let passwordHash = Crypto.MD5(body.password)
            let user = users.filter {($0.username == body.username) && ($0.passwordHash == passwordHash)}
            var response: LoginResponse
            if user.count == 0 {
                response = LoginResponse(
                    result: 0,
                    user: nil,
                    errorMessage: "Wrong login or password"
                )
            }
            else {
                let token = Crypto.MD5("\(user[0].id!)\(user[0].username)")
                user[0].token = token
                response = LoginResponse(
                    result: 1,
                    user: user[0],
                    errorMessage: nil
                )
                let _ = user[0].update(on: req.db)
            }
            print(response)
            return response
        }
            
        return result
    }
    
    func logout(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(LogoutRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)

        let result: EventLoopFuture<CommonResponse> =
        User.query(on: req.db)
            .filter(\.$token == body.token)
            .all()
            .map  { (users: [User]) -> CommonResponse in
                var response: CommonResponse
                if users.count == 0 {
                    response = CommonResponse(
                        result: 0,
                        userMessage: nil,
                        errorMessage: "No such user"
                    )
                } else {
                    response = CommonResponse(
                        result: 1,
                        userMessage: "Succesfully logged out!",
                        errorMessage: nil
                    )
                    users[0].token = nil
                    let _ = users[0].update(on: req.db)
                }
            return response
        }
        return result
    }
    
}
