import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get { req -> String in
        //UUser.query(on: req.db).all()
        
        return "Environment.get("//DATABASE_URL")!
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
