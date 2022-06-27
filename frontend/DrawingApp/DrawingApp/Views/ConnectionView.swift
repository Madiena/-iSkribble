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
                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            TextField(
                "Room",
                text: $roomId
            )
            .frame(width: 200.0, height: 50.0)
            .textFieldStyle(.roundedBorder)
            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            TextField(
                "Name",
                text: $userName
            )
            .frame(width: 200.0, height: 50.0)
            .textFieldStyle(.roundedBorder)
            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            if (roomId.count > 0 && userName.count > 0) {
                Button("Connect") {
                    gameManager.connect(roomId: roomId, userName: userName)
                }
                .background(Color(red: 0.7, green: 0.7, blue: 0.9))
                .foregroundColor(Color.white)
                .buttonStyle(.bordered)
                .clipShape(Capsule())
                
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
