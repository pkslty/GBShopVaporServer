import Vapor
import Fluent
import FluentPostgresDriver


public var database: String?
public var databaseHostName: String?
public var databasePassword: String?
public var databaseUserName: String?

public func configure(_ app: Application) throws {
    getComponents()
    configureDatabase(app)
    try routes(app)
}

public func configureDatabase(_ app: Application) {
    guard
        let database = database,
        let databaseHostName = databaseHostName,
        let databaseUserName = databaseUserName,
        let databasePassword = databasePassword
    else { return }

    app.databases.use(
        .postgres(hostname: databaseHostName,
                  username: databaseUserName,
                  password: databasePassword,
                  database: database,
                  tlsConfiguration: .forClient(certificateVerification: .none)),
        as: .psql)
}

private func getComponents() {
    guard let environment = Environment.get("DATABASE_URL") else { return }
    guard let databaseUrl = URL(string: environment) else { return }
    database = databaseUrl.path.split(separator: "/").last.flatMap(String.init)
    databaseHostName = databaseUrl.host
    databaseUserName = databaseUrl.user
    databasePassword = databaseUrl.password
    
}
