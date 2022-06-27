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
                DrawingPad().scaledToFit()
                
                
                if (gameManager.ownUserIsDrawing) {
                    DrawingControlsButtonView(drawingControlsShown: drawingControlShown)
        
                }
            }
            ChatView().scaledToFit()
        }
   //     .sheet(isPresented: (gameManager.wordsToPickFrom != nil), content: {
   //         PickWordView()
    //    })
   //     .interactiveDismissDisabled(true)
  }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameManager())
    }
}
