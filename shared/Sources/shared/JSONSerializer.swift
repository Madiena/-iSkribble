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
    
    public static func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        return try shared.decoder.decode(type, from: data)
    }
    
    public static func decode<T>(_ type: T.Type, from data: String) throws -> T where T: Decodable {
        return try shared.decoder.decode(type, from: data.data(using: .utf8)!)
    }
    
    public static func encode<T>(_ value: T) throws -> Data where T : Encodable {
        return try shared.encoder.encode(value)
    }
}
