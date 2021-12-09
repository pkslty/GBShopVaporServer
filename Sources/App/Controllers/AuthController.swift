//
//  Auth.swift
//  
//
//  Created by Denis Kuzmin on 09.12.2021.
//
import Vapor

class AuthController {
    func login(_ req: Request) throws -> EventLoopFuture<LoginResponse> {
        guard let body = try? req.content.decode(LoginRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        let users = User.query(on: req.db).all()
        let result: EventLoopFuture<LoginResponse> = users.map { (users: [User]) -> LoginResponse in
            let passwordMD5 = Crypto.MD5(body.password)
            let user = users.filter {($0.login == body.login) && ($0.passwordMD5 == passwordMD5)}
            var response: LoginResponse
            if user.count == 0 {
                response = LoginResponse(
                    result: 0,
                    user: nil,
                    token: nil,
                    errorMessage: "Wrong login or password"
                )
            }
            else {
                let token = Crypto.MD5(String(user[0].id!))
                user[0].token = token
                let userData = UserData(id: user[0].id!,
                                        login: user[0].login,
                                        name: user[0].name,
                                        lastname: user[0].lastname,
                                        email: user[0].email,
                                        gender: user[0].gender,
                                        creditcard: user[0].creditCard,
                                        bio: user[0].bio
                )
                response = LoginResponse(
                    result: 1,
                    user: userData,
                    token: token,
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
        let users = User.query(on: req.db).all()
        let result: EventLoopFuture<CommonResponse> = users.map { (users: [User]) -> CommonResponse in
            let user = users.filter { $0.id == body.id }
            var response: CommonResponse
            if user.count == 0 {
                response = CommonResponse(
                    result: 0,
                    userMessage: nil,
                    errorMessage: "No such user"
                )
            }
            else {
                if user[0].token == nil {
                    response = CommonResponse(
                        result: 0,
                        userMessage: nil,
                        errorMessage: "User was not logged in"
                    )
                }
                else {
                    response = CommonResponse(
                        result: 1,
                        userMessage: "Succesfully logged out!",
                        errorMessage: nil
                    )
                    user[0].token = nil
                    let _ = user[0].update(on: req.db)
                }
            }
            return response
        }
        return result
    }
    
}
