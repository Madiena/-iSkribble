//
//  User.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation
import WebSocketKit

class User: Encodable {
    var webSocket: WebSocket
    var name: String
    var id: UUID
    var room: Room?
    
    init(
        webSocket: WebSocket,
        name: String,
        id: UUID = UUID(),
        room: Room? = nil
    ) {
        self.webSocket = webSocket
        self.name = name
        self.id = id
        self.room = room
    }
    
    enum CodingKeys: String, CodingKey {
           case id
           case name
       }
}
