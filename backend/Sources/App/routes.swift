import Vapor
import Foundation

func routes(_ app: Application) throws {
    try app.register(collection: WebsocketController())
}
