//
//  ConnectionView.swift
//  DrawingApp
//
//  Created by Maik Mursall on 18.06.22.
//

import SwiftUI

struct ConnectionView: View {
    @EnvironmentObject var gameManager: GameManager
    
    @State private var roomId: String = ""
    @State private var userName: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("iSkribble")
            
            TextField(
                "Room",
                text: $roomId
            )
            
            TextField(
                "Name",
                text: $userName
            )
            
            if (roomId.count > 0 && userName.count > 0) {
                Button("Connect") {
                    gameManager.connect(roomId: roomId, userName: userName)
                }
            }
        }
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
