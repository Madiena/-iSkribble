//
//  JSONSerializer.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

struct JSONSerializer {
    static let shared = JSONSerializer()

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    private init() {}
}
