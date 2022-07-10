//
//  GameManager.swift
//  DrawingApp
//
//  Created by Maik Mursall on 09.06.22.
//

import Foundation
import SwiftUI
import shared

class GameManager: NSObject, ObservableObject, WebSocketManagerDelegate {
    private var webSocketManager = WebSocketManager()
    
    @Published var users: [User] = []
    @Published var ownUser: UUID? = nil
    @Published var gameData: GameData? = nil
    @Published var messages: [Message] = []
    @Published var isConnected = false
    @Published var ownUserIsDrawing = false
    
    @Published var currentDrawing: Drawing = Drawing(color: CGColor(red: 0, green: 0, blue: 0, alpha: 1), lineWidth: 3.0)
    @Published var wordsToPickFrom: [String]? = nil
    
    
    override init() {
        super.init()
        
        webSocketManager.delegate = self
    }
    
    func connect(roomId: String, userName: String) {
        let backendURL = (UserDefaults.standard.string(forKey: "backendURL") ?? "localhost:8080")
        
        webSocketManager.connect("ws://\(backendURL)/\(roomId)?name=\(userName)")
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
            self.messages = []
            self.users = []
            self.ownUser = nil
            self.gameData = nil
            self.ownUserIsDrawing = false
        }
    }
    
    func handleSocketEvent(_ socketEvent: SocketEvent) {
        do {
            switch socketEvent.type {
            case .sendMessage:
                try handleSendMessage(socketEvent)
            case .setup :
                try handleSetup(socketEvent)
            case .userConnected :
                try handleUserConnected(socketEvent)
            case .userDisconnected :
                try handleUserDisconnected(socketEvent)
            case .updateGameState:
                try handleUpdateGameState(socketEvent)
            case .updateCanvas:
                try handleUpdateCanvas(socketEvent)
            case .pickWordFromList:
                try handlePickWordFromList(socketEvent)
            default:
                break
            }
        } catch {
            print(error)
            disconnect()
        }
    }
    
    func handleSendMessage(_ socketEvent: SocketEvent) throws {
        let messageData = try JSONSerializer.decode(Message.self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.messages.append(messageData)
        }
    }
    
    func handleSetup(_ socketEvent: SocketEvent) throws {
        let setupData = try JSONSerializer.decode(SetupData.self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.users = setupData.users
            self.ownUser = setupData.ownUser
            self.gameData = setupData.gameData
        }
    }
    
    func handleUserConnected(_ socketEvent: SocketEvent) throws {
        let userData = try JSONSerializer.decode(User.self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.users.append(userData)
        }
    }
    
    func handleUserDisconnected(_ socketEvent: SocketEvent) throws {
        let userData = try JSONSerializer.decode(User.self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.users = self.users.filter { $0.id != userData.id }
        }
    }
    
    func handleUpdateGameState(_ socketEvent: SocketEvent) throws {
        let gameData = try JSONSerializer.decode(GameData.self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.gameData = gameData
            self.ownUserIsDrawing = gameData.currentUserDrawing == self.ownUser
        }
    }
    
    func handleUpdateCanvas(_ socketEvent: SocketEvent) throws {
        let canvasData = try JSONSerializer.decode([Drawing].self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.gameData?.imageData = canvasData
        }
    }
    
    func handlePickWordFromList(_ socketEvent: SocketEvent) throws {
        let wordsData = try JSONSerializer.decode([String].self, from: socketEvent.content!)
        
        DispatchQueue.main.async {
            self.wordsToPickFrom = wordsData
        }
    }
    
    public func sendMessage(_ message: String) {
        webSocketManager.sendSocketEvent(SocketEvent(type: .sendMessage, content: message))
    }
    
    public func sendDrawing() {
        webSocketManager.sendSocketEvent(SocketEvent(type: .addDrawingToCanvas, content: currentDrawing.toJSONString()))
    }
    
    public func undoDrawing() {
        webSocketManager.sendSocketEvent(SocketEvent(type: .undoDrawing, content: nil))
    }
    
    public func clearCanvas() {
        webSocketManager.sendSocketEvent(SocketEvent(type: .clearCanvas, content: nil))
    }
    
    public func pickWord(_ word: String) {
        webSocketManager.sendSocketEvent(SocketEvent(type: .pickWord, content: word))
        wordsToPickFrom = nil
    }
}
