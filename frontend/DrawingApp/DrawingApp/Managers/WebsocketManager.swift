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
}

class WebSocketManager: NSObject {
    private let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var webSocket: WebSocket?
    var delegate: WebSocketManagerDelegate?
    
    override init() {
        super.init()
    }
    
    func connect(_ to: String) {
        let _ = WebSocket.connect(to: to, on: eventLoop) { ws in
            self.webSocket = ws
            
            ws.onText {
                do {
                    let socketEvent = try JSONSerializer.shared.decoder.decode(SocketEvent.self, from: $1.data(using: .utf8)!)
                    self.delegate?.handleSocketEvent(socketEvent)
                } catch {
                    print($0)
                }
            }
        }
    }
    
    func disconnect() {
        let _ = webSocket?.close()
        
        webSocket = nil
    }
    
    func sendSocketEvent(_ socketEvent: SocketEvent) {
        webSocket?.send(payload: socketEvent)
    }
}
