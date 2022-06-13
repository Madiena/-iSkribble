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
    public var users: [User]
    
    public init(ownUser: UUID, gameData: GameData, users: [User]) {
        self.ownUser = ownUser
        self.gameData = gameData
        self.users = users
    }
    
    enum CodingKeys: String, CodingKey {
        case ownUser = "ownUser"
        case gameData = "gameData"
        case users = "users"
    }
}
