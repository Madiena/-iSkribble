//
//  Room.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

public class Room {
    public var users: [User] = []
    public var gameData = GameData()
    public var currentUserDrawingIndex = 0
    
    public init() {}
    
    public func addUser(user: User) {
        users.append(user)
        user.room = self
        
        user.webSocket.send(payload: SocketEvent(type: .setup, content: gameData.toJSONString()))
        
        broadcastToAllUsers(user: user, payload: SocketEvent(type: .userConnected, content: user.toJSONString()))
        
        if (users.count == 1) {
            setNextUserDrawing()
        }
    }
    
    public func removeUser(user: User) {
        users = users.filter { $0.id != user.id }
        user.room = nil
        
        if (users.isEmpty) {
            gameData.currentUserDrawing = nil
            gameData.state = .waiting
            return
        }
        
        broadcastToAllUsers(user: user, payload: SocketEvent(type: .userDisconnected, content: user.toJSONString()))
        
        if (gameData.currentUserDrawing == user.id) {
            setNextUserDrawing()
        }
    }
    
    public func broadcastToAllUsers(payload: SocketEvent) {
        users.forEach { $0.webSocket.send(payload: payload) }
    }
    
    public func broadcastToAllUsers(user: User, payload: SocketEvent) {
        users
            .filter { $0.id != user.id }
            .forEach { $0.webSocket.send(payload: payload) }
    }
    
    public func broadcastGameState() {
        broadcastToAllUsers(payload: SocketEvent(type: .setup, content: gameData.toJSONString()))
    }
    
    public func setNextUserDrawing() {
        currentUserDrawingIndex = (currentUserDrawingIndex + 1) % users.count
        
        gameData.currentUserDrawing = users[currentUserDrawingIndex].id
        gameData.state = .pickingWord
        gameData.imageData = []
        
        broadcastGameState()
    }
    
    public func setPickedWord(word: String) {
        gameData.currentWord = word
        gameData.state = .drawing
        
        broadcastGameState()
    }
    
    public func processGuess(user: User, guess: String) {
        if (guess == gameData.currentWord) {
            gameData.currentWord = ""
            
            let socketEvent = SocketEvent(type: .sendMessage, content: "\(user.name) guessed right!")
            
            broadcastToAllUsers(payload: socketEvent)
            
            setNextUserDrawing()
        }
    }
    
    public func addDrawingToCanvas(drawing: Drawing) {
        gameData.imageData.append(drawing)
        
        broadcastToAllUsers(payload: SocketEvent(type: .updateCanvas, content: gameData.imageData.toJSONString()))
    }
}
