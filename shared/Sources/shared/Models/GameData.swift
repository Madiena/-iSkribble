//
//  GameData.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

public struct GameData: Encodable {
    public var imageData: [Drawing] = []
    public var currentWord = ""
    public var currentUserDrawing: User? = nil
    public var state: GameState = .waiting
}
