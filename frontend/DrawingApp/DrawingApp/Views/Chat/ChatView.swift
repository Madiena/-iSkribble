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
      ZStack(){
          List(gameManager.messages, id: \.self) { message in
              // TODO: Add proper isCurrentUserCheck
              ContentMessageView(contentMessage: message, isCurrentUser: true)
          }.listStyle(.sidebar)
              .offset(y: -55)
           .frame(maxHeight: 430)
          TextField("Enter message", text: $chat)
                        .textFieldStyle(.roundedBorder)
                        .frame(alignment: .bottom)
                        .padding()
                        .font(.title)
                        .foregroundColor(Color.gray)
                        .navigationBarTitle("Chat", displayMode: .inline)
                        .multilineTextAlignment(.leading)
                        .onSubmit {
                            // TODO: Submit message
                            chat = ""
                        }
                        .offset(y: 200)
        }
    }
   
}
    

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
