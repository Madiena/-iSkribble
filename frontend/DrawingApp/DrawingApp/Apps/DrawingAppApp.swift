//
//  DrawingAppApp.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI

@main
struct DrawingAppApp: App {
    @StateObject var gameManager = GameManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
            
            //WebSocketTest(
            //    userName: "TestUser", roomId: "Test"
            //)
            
        }
    }
}
