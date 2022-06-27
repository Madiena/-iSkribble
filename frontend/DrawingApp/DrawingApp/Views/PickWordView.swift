//
//  PickWordView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 20.06.22.
//

import SwiftUI

struct PickWordView: View {
    @EnvironmentObject var gameManager: GameManager
    
    
    var body: some View {
        ForEach (gameManager.wordsToPickFrom ?? [], id: \.self) { word in
            Button(word) {
                gameManager.pickWord(word)
            }
        }
    }
}

struct PickWordView_Previews: PreviewProvider {
    static var previews: some View {
        
        PickWordView().environmentObject(GameManager())
    }
}
