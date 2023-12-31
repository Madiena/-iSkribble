//
//  ChatView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 13.06.22.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var gameManager: GameManager
    
    @State var chat: String = ""
    
    var body: some View {
        VStack{
            List(gameManager.messages, id: \.self) { message in
                ContentMessageView(contentMessage: message.content, isCurrentUser: message.author == gameManager.ownUser)
            }.listStyle(.sidebar)
            
            TextField("Enter message", text: $chat)
                .textFieldStyle(.roundedBorder)
                .frame(alignment: .bottom)
                .padding()
                .font(.title)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
                .onSubmit {
                    gameManager.sendMessage(chat)
                    chat = ""
                }
        }
    }
    
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(GameManager())
    }
}
