//
//  ChatView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 13.06.22.
//

import SwiftUI

struct ChatView: View {
    @State var chat: String = ""
    @State var messages: [String]
    @State var isCurrentUser: Bool
    
      var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing){
                VStack{
                        ForEach(messages, id: \.self) { message in
                         
                                    if !isCurrentUser{
                                        ContentMessageView(contentMessage: message, isCurrentUser: false)
                                    }
                                    else {
                                        ContentMessageView(contentMessage: message, isCurrentUser: true)
                                    }
                                
                        }
                        .padding(4)
                }
                
            TextField("Enter message", text: $chat)
                  .textFieldStyle(.roundedBorder)
                  .frame(alignment: .bottom)
                  .padding()
                  .font(.title)
                  .foregroundColor(Color.gray)
                  .navigationBarTitle("Chat", displayMode: .inline)
                  .multilineTextAlignment(.leading)
                  .onSubmit {
                      messages.append(chat)
                      chat = ""
                  }
                  .offset(y: 200)
            }
        }
      }
   
}
    

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: "", messages: [], isCurrentUser: true)
    }
}
