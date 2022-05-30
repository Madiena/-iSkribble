//
//  RoomService.swift
//  
//
//  Created by Maik Mursall on 30.05.22.
//

import Foundation

class RoomService {
    static let shared = RoomService()
    
    private var test = ""
    
    private init() {}
    
    func changeTest(newTest: String) {
        test = newTest
    }
    
    func getTest() -> String {
        test
    }
}
