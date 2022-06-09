//
//  User.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation
import WebSocketKit

public class User: Encodable {
    public var webSocket: WebSocket
    public var name: String
    public var id: UUID
    public var room: Room?
    
    public init(
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
