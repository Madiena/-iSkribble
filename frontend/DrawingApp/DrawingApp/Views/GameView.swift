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
        VStack(
            alignment: .leading,
            spacing: 0
        ) {
            ZStack(alignment: .leading) {
                LogoutButtonView()
                
                if (gameManager.ownUserIsDrawing) {
                    Text(gameManager.gameData?.currentWord ?? "")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
            }.padding([.top, .leading, .bottom], 5.0)
            
            if (gameManager.wordsToPickFrom == nil) {
                ZStack(alignment: .topLeading) {
                    DrawingPad()
                        .aspectRatio(1, contentMode: .fill)
                        .layoutPriority(1)
                    if (gameManager.ownUserIsDrawing) {
                        DrawingControlsButtonView(drawingControlsShown: drawingControlShown).scaledToFit()
                    }
                    
                }
                ChatView()
            }
            else {
                PickWordView()
                    .frame(maxWidth: .infinity)
            }
        }.frame(maxWidth: .infinity)
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameManager())
    }
}
