//
//  BackendUser.swift
//  
//
//  Created by Maik Mursall on 13.06.22.
//

import Foundation
import shared
import WebSocketKit

class BackendUser: User {
    public var webSocket: WebSocket
    public var room: Room?
    
    public init(
        webSocket: WebSocket,
        name: String,
        id: UUID = UUID(),
        room: Room? = nil
    ) {
        self.webSocket = webSocket
        self.room = room
        
        super.init(name: name, id: id)
    }
}
