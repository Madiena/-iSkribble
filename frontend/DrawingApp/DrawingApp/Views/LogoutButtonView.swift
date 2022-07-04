//
//  LogoutButtonView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 04.07.22.
//

import SwiftUI

struct LogoutButtonView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        
        Button(action: {
            gameManager.disconnect()
            
        })
        {
            Image(systemName: "chevron.backward")
                .font(.system(size: 15))
                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.9))
            Text("Logout")
                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.9))
        }
        
    }
}

struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView()
    }
}
