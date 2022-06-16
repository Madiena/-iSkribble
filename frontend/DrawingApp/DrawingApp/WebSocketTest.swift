//
//  WebSocketTest.swift
//  DrawingApp
//
//  Created by Maik Mursall on 13.06.22.
//

import SwiftUI

struct WebSocketTest: View {
    var userName: String
    var roomId: String
    
    @StateObject var gameManager = GameManager()
    
    var body: some View {
        VStack {
            Text("Status: \(gameManager.isConnected.description)")
            
            if gameManager.isConnected {
                Text(gameManager.ownUser?.description ?? "")
                
                ForEach(gameManager.users, id: \.id) { user in
                    Text("\(user.id): \(user.name)")
                }
                
                ForEach(gameManager.messages, id: \.self) { message in
                    Text(message)
                }
                
                Button("Disconnect") {
                    gameManager.disconnect()
                }
            } else {
                Button("Connect") {
                    gameManager.connect(roomId: roomId, userName: userName)
                }
            }
        }
    }
}

struct WebSocketTest_Previews: PreviewProvider {
    static var previews: some View {
        WebSocketTest(userName: "TestUser", roomId: "TestRoom")
    }
}
