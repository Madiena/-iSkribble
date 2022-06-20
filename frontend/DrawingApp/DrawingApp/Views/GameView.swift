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
    
    @State var drawingControlShown: Bool = true
    @State private var currentDrawing: Drawing = Drawing(color:Color.black, lineWidth: 3.0)
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                DrawingPad(
                    currentDrawing: $currentDrawing,
                    color: $color,
                    lineWidth: $lineWidth
                )
                .frame(width: 310, height: 310, alignment: .center)
//                DrawingControlsButtonView(drawingControlsShown: drawingControlShown)
//                    .offset(x: -120, y: 70)
            }
            ChatView()
                .frame(width: 310, height: 210, alignment: .center)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameManager())
    }
}
