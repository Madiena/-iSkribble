//
//  RoomService.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation
import WebSocketKit

class RoomService {
    static let shared = RoomService()
    
    private var rooms: [String: Room] = [:]
    
    private init() {}
    
    func addUserToRoom(user: User, roomId: String) {
        if let room = rooms[roomId] {
            room.addUser(user: user)
        } else {
            let room = Room()
            room.addUser(user: user)
            
            rooms[roomId] = room
        }
    }
    
    func getRoom(roomId: String) -> Room? {
        return rooms[roomId]
    }
    
    func removeUserFromRoom(user: User, roomId: String) {
        if let room = rooms[roomId] {
            room.removeUser(user: user)
            
            if (room.users.isEmpty) {
                rooms.removeValue(forKey: roomId)
            }
        }
    }
}
