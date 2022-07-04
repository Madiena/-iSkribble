import Vapor
import shared

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    if let port = Environment.get("PORT") {
        app.http.server.configuration.port = Int(port) ?? 8080
    }

    if let hostname = Environment.get("HOSTNAME") {
        app.http.server.configuration.hostname = hostname
    }

    // Initialize words list.
    try WordsProvider.shared.loadWords(app: app)

    // register routes
    try routes(app)
}
