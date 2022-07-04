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
            if (gameManager.isConnected) {
                GameView()
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            LogoutButtonView()
                        }}
                
            } else {
                ConnectionView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameManager())
    }
}
