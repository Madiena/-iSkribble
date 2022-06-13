//
//  GameManager.swift
//  DrawingApp
//
//  Created by Maik Mursall on 09.06.22.
//

import Foundation
import shared

class GameManager: NSObject, ObservableObject, WebSocketManagerDelegate {
    private var webSocketManager = WebSocketManager()
    
    @Published var drawing = []
    @Published var messages: [String] = []
    @Published var isConnected = false
    
    override init() {
        super.init()
        
        webSocketManager.delegate = self
    }

    func connect(roomId: String, userName: String) {
        webSocketManager.connect("ws://localhost:8080/\(roomId)?name=\(userName)")
    }
    
    func disconnect() {
        webSocketManager.disconnect()
    }
    
    func handleOnConnect() {
        print("Connected")
        
        DispatchQueue.main.async {
            self.isConnected = true
        }
    }
    
    func handleOnDisconnect() {
        print("Disconnected")
        
        DispatchQueue.main.async {
            self.isConnected = false
        }
    }
    
    func handleSocketEvent(_ socketEvent: SocketEvent) {
        print(socketEvent)
        
        switch socketEvent.type {
            case .sendMessage:
                DispatchQueue.main.async {
                    self.messages.append(socketEvent.content!)
                }
            default:
                break
        }
    }
}
