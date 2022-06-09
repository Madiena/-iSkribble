//
//  EventType.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation

public enum EventType: String, Codable {
    // Server events
    case updateGameState
    case userConnected
    case userDisconnected
    case setup
    case updateCanvas
    case drawingPlayerChanged
    
    // Client events
    case sendMessage
    case addDrawingToCanvas
    case pickWord
}
