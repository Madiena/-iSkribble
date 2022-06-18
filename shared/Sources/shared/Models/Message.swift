//
//  Message.swift
//  
//
//  Created by Maik Mursall on 18.06.22.
//

import Foundation

public struct Message: Codable, Hashable {
    public var author: UUID
    public var content: String
    
    public init(author: UUID, content: String) {
        self.author = author
        self.content = content
    }
}
