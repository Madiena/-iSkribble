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
    
    @Published var users: [User] = []
    @Published var ownUser: UUID? = nil
    @Published var gameData: GameData? = nil
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
            self.messages = []
            self.users = []
            self.ownUser = nil
            self.gameData = nil
        }
    }
    
    func handleSocketEvent(_ socketEvent: SocketEvent) {
        print(socketEvent)
        
        switch socketEvent.type {
            case .sendMessage:
                handleSendMessage(socketEvent)
            case .setup :
                handleSetup(socketEvent)
            default:
                break
        }
    }
    
    func handleSendMessage(_ socketEvent: SocketEvent) {
        DispatchQueue.main.async {
            self.messages.append(socketEvent.content!)
        }
    }
    
    func handleSetup(_ socketEvent: SocketEvent) {
        do {
            let setupData = try JSONSerializer.decode(SetupData.self, from: socketEvent.content!)

            DispatchQueue.main.async {
                self.users = setupData.users
                self.ownUser = setupData.ownUser
                self.gameData = setupData.gameData
            }
        } catch {
            print(error)
            disconnect()
        }
    }
    
    func handleUserConnected(_ socketEvent: SocketEvent) {
        do {
            let userData = try JSONSerializer.decode(User.self, from: socketEvent.content!)
            
            DispatchQueue.main.async {
                self.users.append(userData)
            }
        } catch {
            print(error)
            disconnect()
        }
    }
}
