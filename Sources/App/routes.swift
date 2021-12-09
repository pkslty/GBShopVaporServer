import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get { req -> String in
        let uu = User.query(on: req.db).all()
        
        let u = uu.map { value in
            value[0].name
        }
        print(u)
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    let userController = UserController()
    let authController = AuthController()
    app.post("register", use: userController.register)
    app.post("changeUserData", use: userController.changeUserData)
    app.post("login", use: authController.login)
    app.post("logout", use: authController.logout)
}
