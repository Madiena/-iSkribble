//
//  ContentView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI
import shared

struct ContentView: View {
    @State private var currentDrawing: Drawing = Drawing(color:Color.black, lineWidth: 3.0)
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    @State private var chat: String = ""
    @State private var messages: [String] = []
    @State private var isCurrentUser: Bool = true
    @State private var isPickingWord: Bool = true
    @State private var word: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
        Text("Draw something!")
            .font(.largeTitle)
            .padding()
        /*    if(isPickingWord) {
                WordEntry(text: word, pickWord: isPickingWord)
            } else  {*/
                DrawingPad(currentDrawing: $currentDrawing,
                drawings: $drawings,
                color: $color,
                lineWidth: $lineWidth)
                ChatView(chat: chat, messages: messages, isCurrentUser: isCurrentUser)
                .offset(y: 50)
                DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth)
                .fixedSize(horizontal: 100 != 0, vertical: 50 != 0)
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
