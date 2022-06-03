//
//  Room.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

class Room {
    var users: [User] = []
    
    init() {}
    
    func addUser(user: User) {
        users.append(user)
        user.room = self
        
        print(users)
    }
    
    func removeUser(user: User) {
        users = users.filter { $0.id != user.id }
        user.room = nil
    }
    
    func broadcastToAllUsers(payload: String) {
        users.forEach { $0.webSocket.send(payload) }
    }
    
    func broadcastToAllUsers(user: User, payload: String) {
        users
            .filter { $0.id != user.id }
            .forEach { $0.webSocket.send(payload) }
    }
}
