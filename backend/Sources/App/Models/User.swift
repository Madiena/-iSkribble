//
//  User.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation
import WebSocketKit

class User {
    var webSocket: WebSocket
    var id: UUID
    var room: Room?
    
    init(webSocket: WebSocket, id: UUID = UUID(), room: Room? = nil) {
        self.webSocket = webSocket
        self.id = id
        self.room = room
    }
}
