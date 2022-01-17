import Vapor
import Fluent
import FluentPostgresDriver

public var database: String? = "d5fdm9l28db7hp"
public var databaseHostname: String? = "ec2-34-254-120-2.eu-west-1.compute.amazonaws.com"
public var databaseUsername: String? = "zjvubjavcoaeyw"
public var databasePassword: String? = "91df1e4c17bd63c2c6f4864eb4492980fa1a3564e971e2d4434ff2b29bc8f2f9"

public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    let databaseUrl = Environment.get("DATABASE_URL")?.split(separator: "@")
    let components = databaseUrl.map { $0.split(separator: ":") }
    let database1 = components?.last?.split(separator: "/").last
    let databaseHostName1 = components?[3]
    let databasePassword1 = components?[2]
    let databaseUserName1 = components?[1].split(separator: "/").last
    
    print(database1)
    print(databaseHostName1)
    print(databasePassword1)
    print(databaseUserName1)
    
    configureDatabase(app)

    try routes(app)
}

public func configureDatabase(_ app: Application) {
    guard
        let database = database,
        let databaseHostname = databaseHostname,
        let databaseUsername = databaseUsername,
        let databasePassword = databasePassword
    else { return }
    //try app.databases.use(.postgres(url: "postgres://zjvubjavcoaeyw:91df1e4c17bd63c2c6f4864eb4492980fa1a3564e971e2d4434ff2b29bc8f2f9@ec2-34-254-120-2.eu-west-1.compute.amazonaws.com:5432/d5fdm9l28db7hp"), as: .psql)
    app.databases.use(
        .postgres(hostname: databaseHostname,
                  username: databaseUsername,
                  password: databasePassword,
                  database: database,
                  tlsConfiguration: .forClient(certificateVerification: .none)),
        as: .psql)
}
