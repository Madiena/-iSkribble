//
//  ChatView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 13.06.22.
//

import SwiftUI

struct ChatView: View {
    @State var chat = ""
    @State var messages: [String]
    @State var isCurrentUser: Bool
    
      var body: some View {
        NavigationView {
            VStack {
                Group {
                    ForEach(messages, id: \.self) {message in
                        HStack(alignment: .bottom, spacing: 15) {
                            if !isCurrentUser{
                              ContentMessageView(contentMessage: message, isCurrentUser: false)
                            }
                            else {
                                ContentMessageView(contentMessage: message, isCurrentUser: true)
                            }
                        }
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom)
            TextField("Enter message", text: $chat)
                  .textFieldStyle(.roundedBorder)
                  .frame(alignment: .bottom)
                  .padding()
                  .font(.title)
                  .foregroundColor(Color.gray)
                  .navigationBarTitle("Chat", displayMode: .inline)
                  .multilineTextAlignment(.leading)
            }
        }
      }
   
}
    

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: "", messages: ["hi", "ih", "hi","hddfsbfbgk"], isCurrentUser: true)
    }
}
