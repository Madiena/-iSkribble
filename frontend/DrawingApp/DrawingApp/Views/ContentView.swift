//
//  ContentView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        NavigationView {
            VStack {
                if (gameManager.isConnected) {
                    //LogoutButtonView()
                    GameView()
                    
                } else {
                    ConnectionView()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameManager())
    }
}
