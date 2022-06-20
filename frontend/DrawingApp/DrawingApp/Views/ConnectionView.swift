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
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            TextField(
                "Room",
                text: $roomId
            )
            .frame(width: 200.0, height: 50.0)
            .textFieldStyle(.roundedBorder)
            
            TextField(
                "Name",
                text: $userName
            )
            .frame(width: 200.0, height: 50.0)
            .textFieldStyle(.roundedBorder)
            
            if (roomId.count > 0 && userName.count > 0) {
                Button("Connect") {
                    gameManager.connect(roomId: roomId, userName: userName)
                }
                .frame(height: nil)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
            .environmentObject(GameManager())
    }
}
