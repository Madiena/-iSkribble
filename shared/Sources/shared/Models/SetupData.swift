//
//  SetupData.swift
//  
//
//  Created by Maik Mursall on 13.06.22.
//

import Foundation

public struct SetupData: Codable {
    public var ownUser: UUID
    public var gameData: GameData
    
    public init(ownUser: UUID, gameData: GameData) {
        self.ownUser = ownUser
        self.gameData = gameData
    }
}
