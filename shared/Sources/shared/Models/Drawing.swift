//
//  Drawing.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation

public struct Drawing: Codable {
    public var path: [CGPoint]
    public var color: CGColor
    public var lineWidth: CGFloat
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case color = "color"
        case lineWidth = "lineWidth"
    }
    
    public init(path: [CGPoint], color: CGColor, lineWidth: CGFloat) {
        self.path = path
        self.color = color
        self.lineWidth = lineWidth
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let tempPath = try values.decode(Array<Array<Double>>.self, forKey: .path)
        path = tempPath.map { CGPoint(x: $0[0], y: $0[1]) }
        
        let tempColor = try values.decode(Array<CGFloat>.self, forKey: .color)
        color = CGColor(
            red: CGFloat(tempColor[0]),
            green: CGFloat(tempColor[1]),
            blue: CGFloat(tempColor[2]),
            alpha: CGFloat(tempColor[3])
        )
        
        let tempLineWdith = try values.decode(Float.self, forKey: .lineWidth)
        lineWidth = CGFloat(lineWidth)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(path.map { [$0.x, $0.y] }, forKey: .path)
        try container.encode(color.components, forKey: .color)
        try container.encode(Float(lineWidth), forKey: .lineWidth)
    }
}
