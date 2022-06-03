//
//  Room.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

class Room {
    var users: [User] = []
    var gameData = GameData()
    var currentUserDrawingIndex = 0
    
    init() {}
    
    func addUser(user: User) {
        users.append(user)
        user.room = self
        
        do {
            let data = String(data: try JSONSerializer.shared.encoder.encode(gameData), encoding: .utf8)!
            
            user.webSocket.send(payload: SocketEvent(type: .setup, content: data))
        } catch {}
        
        broadcastToAllUsers(user: user, payload: SocketEvent(type: .userConnected, content: user.toJSONString()))
        
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
        
        broadcastToAllUsers(user: user, payload: SocketEvent(type: .userDisconnected, content: user.toJSONString()))
        
        if (gameData.currentUserDrawing?.id == user.id) {
            setNextUserDrawing()
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
        do {
            let data = String(data: try JSONSerializer.shared.encoder.encode(gameData), encoding: .utf8)!
            
            broadcastToAllUsers(payload: SocketEvent(type: .setup, content: data))
        } catch {}
    }
    
    func setNextUserDrawing() {
        currentUserDrawingIndex = (currentUserDrawingIndex + 1) % users.count
        
        gameData.currentUserDrawing = users[currentUserDrawingIndex]
        gameData.state = .pickingWord
        gameData.imageData = []
        
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
    
    func addDrawingToCanvas(drawing: Drawing) {
        gameData.imageData.append(drawing)
        
        do {
            let data = String(data: try JSONSerializer.shared.encoder.encode(gameData.imageData), encoding: .utf8)!
            
            broadcastToAllUsers(payload: SocketEvent(type: .updateCanvas, content: data))
        } catch {}
    }
}
