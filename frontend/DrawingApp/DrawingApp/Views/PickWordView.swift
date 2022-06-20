//
//  PickWordView.swift
//  DrawingApp
//
//  Created by Lothar Hestermann on 20.06.22.
//

import SwiftUI

struct PickWordView: View {
    @EnvironmentObject var gameManager: GameManager
    
    
    var body: some View {
        VStack {
            ForEach (gameManager.wordsToPickFrom ?? [], id: \.self) { word in
                Button(word) {
                    gameManager.pickWord(word)
                }.buttonStyle(.borderedProminent)
            }
        }
    }
}

struct PickWordView_Previews: PreviewProvider {
    static var previews: some View {
        
        PickWordView().environmentObject(GameManager())
    }
}
