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
    @State var drawingControlShown: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            if (gameManager.wordsToPickFrom == nil) {
                ZStack(alignment: .topLeading) {
                    DrawingPad().scaledToFit()
                    if (gameManager.ownUserIsDrawing) {
                        DrawingControlsButtonView(drawingControlsShown: drawingControlShown).scaledToFit()
                    }
                    
                }
                ChatView().scaledToFit()
            }
            else {
                PickWordView()
            }
        }
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameManager())
    }
}
