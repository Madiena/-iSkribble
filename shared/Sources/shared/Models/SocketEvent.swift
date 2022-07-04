//
//  SocketEvent.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation

public struct SocketEvent: Codable {
    public var type: EventType
    public var content: String?
    
    public init(type: EventType, content: String?) {
        self.type = type
        self.content = content
    }
}
