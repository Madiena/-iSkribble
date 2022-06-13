//
//  WordEntry.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 09.06.22.
//

import SwiftUI


struct WordEntry: View {
    @State var text: String
    @State var pickWord: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter word here").font(.title)
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search...", text: $text)
                        }.padding()
                        .textFieldStyle(DefaultTextFieldStyle())
            Button(action: {
                pickWord = false;
                }) {
                Text("Enter")
                        .foregroundColor( Color.white)
                }.padding()
                .background(Color(red: 0.7, green: 0.7, blue: 0.9))
                .clipShape(Capsule())
        }.padding()
    }
}

struct WordEntry_Previews: PreviewProvider {
    static var previews: some View {
        WordEntry(text: "", pickWord: true)
    }
}
