//
//  ContentMessageView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 13.06.22.
//

import SwiftUI

struct ContentMessageView: View {
   @State var contentMessage: String
   @State var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color(red: 0.4, green: 0.4, blue: 0.4))
            .background(isCurrentUser ? Color(red: 0.7, green: 0.7, blue: 0.9) : Color(UIColor(red: 0.7, green: 0.7, blue: 0.9, alpha: 0.3)))
            .cornerRadius(10)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMessageView(contentMessage: "hi", isCurrentUser: true)
    }
}
