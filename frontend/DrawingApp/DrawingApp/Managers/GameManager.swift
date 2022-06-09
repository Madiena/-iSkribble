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

    init(currentRoom: String, username: String) {
        super.init()
        
        webSocketManager.delegate = self
        
        webSocketManager.connect("ws://localhost:8080/\(currentRoom)?name=\(username)")
    }
    
    func handleSocketEvent(_ socketEvent: SocketEvent) {
        print(socketEvent)
    }
}
