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
        
        print("Connected to \(roomId)")
        
        ws.send("Hello to \(roomId)")
        
        ws.onText(handleOnText)
    }
    
    func handleOnText(ws: WebSocket, payload: String) {
        let socketEvent = try! decoder.decode(SocketEvent.self, from: payload.data(using: .utf8)!)
        
        switch socketEvent.type {
            case .setup:
                handleSetup(ws, socketEvent)
            case .get:
                handleGet(ws, socketEvent)
        }
    }
    
    func handleSetup(_ ws: WebSocket, _ socketEvent: SocketEvent) {
        RoomService.shared.changeTest(newTest: socketEvent.content!)
        
        print("Handle setup \(socketEvent.content!)")
        
        ws.send(RoomService.shared.getTest())
    }
    
    func handleGet(_ ws: WebSocket, _ socketEvent: SocketEvent) {
        ws.send(RoomService.shared.getTest())
    }
}
