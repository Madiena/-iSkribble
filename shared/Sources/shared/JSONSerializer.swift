//
//  JSONSerializer.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

public struct JSONSerializer {
    public static let shared = JSONSerializer()

    public let encoder = JSONEncoder()
    public let decoder = JSONDecoder()
    
    private init() {}
}
