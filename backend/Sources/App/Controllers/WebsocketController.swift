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
    private let encoder = JSONEncoder()
    
    func boot(routes: RoutesBuilder) throws {
        routes.webSocket(":roomId", onUpgrade: initWebsocket)
    }
    
    func initWebsocket(_ req: Request, _ ws: WebSocket) {
        let roomId = req.parameters.get("roomId")!
        let name: String = req.query["name"]!
        
        let user = User(webSocket: ws, name: name)
        
        RoomService.shared.addUserToRoom(user: user, roomId: roomId)
        
        ws.onText {
            let socketEvent = try! decoder.decode(SocketEvent.self, from: $1.data(using: .utf8)!)

            handleSocketEvent(user, socketEvent)
        }
        
        ws.onClose.whenComplete { _ in
            RoomService.shared.removeUserFromRoom(user: user, roomId: roomId)
        }
    }
    
    func handleSocketEvent(_ user: User, _ socketEvent: SocketEvent) {
        switch socketEvent.type {
            case .sendMessage:
                handleSendMessage(user, socketEvent)
            case .updateCanvas:
                handleUpdateCanvas(user, socketEvent)
            case .pickWord:
                handlePickWord(user, socketEvent)
            default:
                break
        }
    }
    
    func handleSendMessage(_ user: User, _ socketEvent: SocketEvent) {
        if let room = user.room {
            room.processGuess(user: user, guess: socketEvent.content!)
            room.broadcastToAllUsers(payload: socketEvent)
        }
    }
    
    func handleUpdateCanvas(_ user: User, _ socketEvent: SocketEvent) {
        user.webSocket.send(user.room?.users.map { $0.name }.description ?? "error")
    }
    
    func handlePickWord(_ user: User, _ socketEvent: SocketEvent) {
        if let room = user.room {
            room.setPickedWord(word: socketEvent.content!)
        }
    }
}
