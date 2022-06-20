//
//  WebsocketController.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation
import Vapor
import shared

struct WebsocketController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.webSocket(":roomId", onUpgrade: initWebsocket)
    }
    
    func initWebsocket(_ req: Request, _ ws: WebSocket) {
        let roomId = req.parameters.get("roomId")!
        let name: String = req.query["name"]!
        
        let user = BackendUser(webSocket: ws, name: name)
        
        
        RoomService.shared.addUserToRoom(user: user, roomId: roomId)
        
        ws.onText {
            do {
                let socketEvent = try JSONSerializer.shared.decoder.decode(SocketEvent.self, from: $1.data(using: .utf8)!)
                
                handleSocketEvent(user, socketEvent)
            } catch {
                print($0)
            }
        }
        
        ws.onClose.whenComplete { _ in
            RoomService.shared.removeUserFromRoom(user: user, roomId: roomId)
        }
    }
    
    func handleSocketEvent(_ user: BackendUser, _ socketEvent: SocketEvent) {
        switch socketEvent.type {
            case .sendMessage:
                handleSendMessage(user, socketEvent)
            case .addDrawingToCanvas:
                handleAddDrawingToCanvas(user, socketEvent)
            case .pickWord:
                handlePickWord(user, socketEvent)
            case .undoDrawing:
                handleUndoDrawing(user)
            case .clearCanvas:
                handleClearCanvas(user)
            default:
                break
        }
    }
    
    func handleSendMessage(_ user: BackendUser, _ socketEvent: SocketEvent) {
        if let room = user.room {
            room.processGuess(user: user, guess: socketEvent.content!)
            room.broadcastToAllUsers(
                payload: SocketEvent(
                    type: .sendMessage,
                    content: Message(
                        author: user.id,
                        content: socketEvent.content!
                    ).toJSONString()
                )
            )
        }
    }
    
    func handleAddDrawingToCanvas(_ user: BackendUser, _ socketEvent: SocketEvent) {
        do {
            let drawing = try JSONSerializer.shared.decoder.decode(Drawing.self, from: socketEvent.content!.data(using: .utf8)!)
            
            if let room = user.room {
                room.addDrawingToCanvas(drawing: drawing)
            }
        } catch {}
    }
    
    func handlePickWord(_ user: BackendUser, _ socketEvent: SocketEvent) {
        if let room = user.room {
            room.setPickedWord(word: socketEvent.content!)
        }
    }

    func handleUndoDrawing(_ user: BackendUser) {
        if let room = user.room {
            room.undoDrawing()
        }
    }

    func handleClearCanvas(_ user: BackendUser) {
        if let room = user.room {
            room.clearCanvas()
        }
    }
}
