//
//  WebsocketController.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation
import Vapor

struct WebsocketController: RouteCollection {
    private let decoder = JSONDecoder()
    
    func boot(routes: RoutesBuilder) throws {
        routes.webSocket(":roomId", onUpgrade: initWebsocket)
    }
    
    func initWebsocket(_ req: Request, _ ws: WebSocket) {
        let roomId = req.parameters.get("roomId")!
        
        let user = User(webSocket: ws)
        
        RoomService.shared.addUserToRoom(user: user, roomId: roomId)
        
        ws.onText {
            let socketEvent = try! decoder.decode(SocketEvent.self, from: $1.data(using: .utf8)!)
            
            switch socketEvent.type {
                case .setup:
                    handleSetup(user, socketEvent)
                case .get:
                    handleGet(user, socketEvent)
            }
        }
        
        ws.onClose.whenComplete {_ in
            RoomService.shared.removeUserFromRoom(user: user, roomId: roomId)
        }
    }
    
    func handleSetup(_ user: User, _ socketEvent: SocketEvent) {
    }
    
    func handleGet(_ user: User, _ socketEvent: SocketEvent) {
        user.webSocket.send(user.room?.users.debugDescription ?? "bruh")
    }
}
