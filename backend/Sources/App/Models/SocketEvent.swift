//
//  File.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation

struct SocketEvent: Codable {
    var type: EventType
    var content: String?
}
