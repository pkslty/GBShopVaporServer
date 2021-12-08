import Vapor
import Fluent
import FluentPostgresDriver



// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(
        .postgres(hostname: "ec2-34-254-120-2.eu-west-1.compute.amazonaws.com",
                  username: "zjvubjavcoaeyw",
                  password: "91df1e4c17bd63c2c6f4864eb4492980fa1a3564e971e2d4434ff2b29bc8f2f9", database: "d5fdm9l28db7hp"),
        as: .psql)
    // register routes
    try routes(app)
}

