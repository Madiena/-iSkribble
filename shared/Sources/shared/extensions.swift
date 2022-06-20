//
//  extensions.swift
//  
//
//  Created by Maik Mursall on 03.06.22.
//

import Foundation
import WebSocketKit

public extension WebSocket {
    func send(payload: SocketEvent) {
        let data = try! JSONSerializer.shared.encoder.encode(payload)
        
        self.send(String(data: data, encoding: .utf8)!)
    }
}

public extension Encodable {
    func toJSONString() -> String {
        return String(data: try! JSONSerializer.shared.encoder.encode(self), encoding: .utf8)!
    }
}
