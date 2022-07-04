import Vapor
import shared

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Initialize words list.
    try WordsProvider.shared.loadWords(app: app)

    // register routes
    try routes(app)
}
