//
//  GameData.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

struct GameData: Encodable {
    var imageData = Data()
    var currentWord = ""
    var currentUserDrawing: User? = nil
    var state: GameState = .waiting
}
