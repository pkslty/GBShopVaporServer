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
    
    let controller = UserController()
    app.post("register", use: controller.register)
    app.post("changeUserData", use: controller.changeUserData)
}
