//
//  GameView.swift
//  DrawingApp
//
//  Created by Maik Mursall on 18.06.22.
//

import SwiftUI
import shared

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    
    @State private var currentDrawing: Drawing = Drawing(color:Color.black, lineWidth: 3.0)
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Draw something!")
                .font(.largeTitle)
                .padding()
            DrawingPad(
                currentDrawing: $currentDrawing,
                color: $color,
                lineWidth: $lineWidth
            )
            ChatView()
                .offset(y: 50)
            DrawingControls(color: $color, lineWidth: $lineWidth)
                .fixedSize(horizontal: 100 != 0, vertical: 50 != 0)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
