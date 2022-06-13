//
//  Room.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

public class Room {
    public var users: [User] = []
    public var gameData = GameData()
    public var currentUserDrawingIndex = 0
    
    public init() {}
}
