//
//  Room.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

class Room {
    private let encoder = JSONEncoder()
    
    var users: [User] = []
    var gameData = GameData()
    var currentUserDrawingIndex = 0
    
    init() {}
    
    func addUser(user: User) {
        users.append(user)
        user.room = self
        
        if (users.count == 1) {
            setNextUserDrawing()
        }
    }
    
    func removeUser(user: User) {
        users = users.filter { $0.id != user.id }
        user.room = nil
        
        if (users.isEmpty) {
            gameData.currentUserDrawing = nil
            gameData.state = .waiting
            return
        }
    }
    
    func broadcastToAllUsers(payload: SocketEvent) {
        users.forEach { $0.webSocket.send(payload: payload) }
    }
    
    func broadcastToAllUsers(user: User, payload: SocketEvent) {
        users
            .filter { $0.id != user.id }
            .forEach { $0.webSocket.send(payload: payload) }
    }
    
    func broadcastGameState() {
        let data = String(data: try! encoder.encode(gameData), encoding: .utf8)!
        
        broadcastToAllUsers(payload: SocketEvent(type: .setup, content: data))
    }
    
    func setNextUserDrawing() {
        currentUserDrawingIndex = (currentUserDrawingIndex + 1) % users.count
        
        gameData.currentUserDrawing = users[currentUserDrawingIndex]
        gameData.state = .pickingWord
        
        broadcastGameState()
    }
    
    func setPickedWord(word: String) {
        gameData.currentWord = word
        gameData.state = .drawing
        
        broadcastGameState()
    }
    
    func processGuess(user: User, guess: String) {
        if (guess == gameData.currentWord) {
            gameData.currentWord = ""
            
            let socketEvent = SocketEvent(type: .sendMessage, content: "\(user.name) guessed right!")
            
            broadcastToAllUsers(payload: socketEvent)
            
            setNextUserDrawing()
        }
    }
}
