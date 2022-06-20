//
//  MessageView.swift
//  DrawingApp
//
//  Created by Lothar Hestermann on 16.06.22.
//

import SwiftUI

struct MessageView: View {
    @State var messages: [String]
    @State var isCurrentUser: Bool
    
    var body: some View {
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
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(messages: ["Hi"], isCurrentUser: true)
    }
}
