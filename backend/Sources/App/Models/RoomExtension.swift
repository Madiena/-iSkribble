//
//  RoomExtension.swift
//  
//
//  Created by Maik Mursall on 13.06.22.
//

import Foundation
import shared

extension Room {
    func addUser(user: BackendUser) {
        users.append(user)
        user.room = self
        
        let setupData = SetupData(ownUser: user.id, gameData: gameData)
        user.webSocket.send(payload: SocketEvent(type: .setup, content: setupData.toJSONString()))
        
        broadcastToAllUsers(user: user, payload: SocketEvent(type: .userConnected, content: user.toJSONString()))
        
        if (users.count == 1) {
            setNextUserDrawing()
        }
    }
    
    func removeUser(user: BackendUser) {
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
    
    func broadcastToAllUsers(payload: SocketEvent) {
        users.forEach { ($0 as! BackendUser).webSocket.send(payload: payload) }
    }
    
    func broadcastToAllUsers(user: User, payload: SocketEvent) {
        users
            .filter { $0.id != user.id }
            .forEach { ($0 as! BackendUser).webSocket.send(payload: payload) }
    }
    
    func broadcastGameState() {
        broadcastToAllUsers(payload: SocketEvent(type: .setup, content: gameData.toJSONString()))
    }
    
    func setNextUserDrawing() {
        currentUserDrawingIndex = (currentUserDrawingIndex + 1) % users.count
        
        gameData.currentUserDrawing = users[currentUserDrawingIndex].id
        gameData.state = .pickingWord
        gameData.imageData = []
        
        broadcastGameState()
        
        let socketEvent = SocketEvent(type: .pickWordFromList, content: ["test1", "test2", "test3"].toJSONString())
        (users[currentUserDrawingIndex] as! BackendUser).webSocket.send(payload: socketEvent)
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
        
        broadcastToAllUsers(payload: SocketEvent(type: .updateCanvas, content: gameData.imageData.toJSONString()))
    }
}
