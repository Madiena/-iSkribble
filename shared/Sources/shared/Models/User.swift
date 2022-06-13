//
//  User.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

open class User: Encodable {
    public var name: String
    public var id: UUID
    
    public init(
        name: String,
        id: UUID = UUID()
    ) {
        self.name = name
        self.id = id
    }
}
