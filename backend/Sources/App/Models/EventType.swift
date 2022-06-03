//
//  EventType.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation

enum EventType: String, Codable {
    // Server events
    case updateGameState
    case userConnected
    case userDisconnected
    case setup
    
    // Client events
    case sendMessage
    case updateCanvas
    case pickWord
}
