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
        VStack {
            ForEach (gameManager.wordsToPickFrom ?? [], id: \.self) { word in
                Button(word) {
                    gameManager.pickWord(word)
                }.buttonStyle(.bordered)
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.7, green: 0.7, blue: 0.9))
                    .clipShape(Capsule())
                
            }
        }
    }
}

struct PickWordView_Previews: PreviewProvider {
    static var previews: some View {
        
        PickWordView().environmentObject(GameManager())
    }
}
