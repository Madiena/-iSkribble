//
//  WebsocketManager.swift
//  DrawingApp
//
//  Created by Maik Mursall on 09.06.22.
//

import Foundation
import WebSocketKit
import NIOPosix
import shared

protocol WebSocketManagerDelegate {
    func handleSocketEvent(_ socketEvent: SocketEvent)
    func handleOnConnect()
    func handleOnDisconnect()
}

class WebSocketManager: NSObject {
    private let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var webSocket: WebSocket?
    var delegate: WebSocketManagerDelegate?
    
    func connect(_ to: String) {
        let _ = WebSocket.connect(to: to, on: eventLoop) { ws in
            self.webSocket = ws
            
            self.delegate?.handleOnConnect()
            
            ws.onText {
                do {
                    let socketEvent = try JSONSerializer.decode(SocketEvent.self, from: $1)
                    self.delegate?.handleSocketEvent(socketEvent)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func disconnect() {
        let _ = webSocket?.close()
        
        webSocket = nil
        
        delegate?.handleOnDisconnect()
    }
    
    func sendSocketEvent(_ socketEvent: SocketEvent) {
        webSocket?.send(payload: socketEvent)
    }
}
