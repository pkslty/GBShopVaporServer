import Vapor
import PostgresKit

func routes(_ app: Application) throws {
    app.get { req -> String in
        
        let databaseConfig: PostgresConfiguration
        if let url = Environment.get("DATABASE_URL") {
          // configuring database
          databaseConfig = PostgresConfiguration(url: url)!
        } else {
          // ...
        }
        
        return "Database configured!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
