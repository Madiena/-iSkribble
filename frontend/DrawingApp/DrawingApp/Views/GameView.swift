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
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                DrawingPad()
                    .frame(width: 310, height: 310, alignment: .center)
                
                if (gameManager.ownUserIsDrawing) {
                    DrawingControlsButtonView(drawingControlsShown: drawingControlShown)
                        .offset(x: -120, y: 70)
                }
            }
            ChatView()
                .frame(width: 310, height: 210, alignment: .center)
        }
        .sheet(isPresented: (gameManager.wordsToPickFrom != nil), content: {
            PickWordView()
        })
        .interactiveDismissDisabled(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameManager())
    }
}
