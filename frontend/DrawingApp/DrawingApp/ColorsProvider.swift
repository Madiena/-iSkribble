//
//  ColorsProvider.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 06.06.22.
//

import SwiftUI

struct ColorInfo: Identifiable {
    let id: Int
    let displayName: String
    let color: Color
    
}

class ColorsProvider {
    static func supportedColors() -> [ColorInfo] {
        return [ColorInfo(id: 1, displayName: "Black", color: Color.black),
                ColorInfo(id: 2, displayName: "Blue", color: Color.blue),
                ColorInfo(id: 3, displayName: "Brown", color: Color.brown),
                ColorInfo(id: 4, displayName: "Gray", color: Color.gray),
                ColorInfo(id: 5, displayName: "Green", color: Color.green),
                ColorInfo(id: 6, displayName: "Indigo", color: Color.indigo),
                ColorInfo(id: 7, displayName: "Mint", color: Color.mint),
                ColorInfo(id: 8, displayName: "Cyan", color: Color.cyan),
                ColorInfo(id: 9, displayName: "Orange", color: Color.orange),
                ColorInfo(id: 10, displayName: "Pink", color: Color.pink),
                ColorInfo(id: 11, displayName: "Purple", color: Color.purple),
                ColorInfo(id: 12, displayName: "Red", color: Color.red),
                ColorInfo(id: 13, displayName: "Yellow", color: Color.yellow),
                ColorInfo(id: 14, displayName: "White", color: Color.white)]
    }
}
