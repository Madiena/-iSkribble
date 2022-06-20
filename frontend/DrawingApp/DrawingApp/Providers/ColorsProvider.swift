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
    let color: CGColor
    
}

class ColorsProvider {
    static func supportedColors() -> [ColorInfo] {
        return [ColorInfo(id: 1, displayName: "Black", color: UIColor.black.cgColor),
                ColorInfo(id: 2, displayName: "Blue", color: UIColor.blue.cgColor),
                ColorInfo(id: 3, displayName: "Brown", color: UIColor.brown.cgColor),
                ColorInfo(id: 4, displayName: "Gray", color: UIColor.gray.cgColor),
                ColorInfo(id: 5, displayName: "Green", color: UIColor.green.cgColor),
                ColorInfo(id: 6, displayName: "Cyan", color: UIColor.cyan.cgColor),
                ColorInfo(id: 7, displayName: "Orange", color: UIColor.orange.cgColor),
                ColorInfo(id: 8, displayName: "Purple", color: UIColor.purple.cgColor),
                ColorInfo(id: 9, displayName: "Red", color: UIColor.red.cgColor),
                ColorInfo(id: 10, displayName: "Yellow", color: UIColor.yellow.cgColor),
                ColorInfo(id: 11, displayName: "White", color: UIColor.white.cgColor)]
    }
}
