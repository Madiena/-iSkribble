//
//  SettingsView.swift
//  DrawingApp
//
//  Created by Maik Mursall on 10.07.22.
//

import SwiftUI

struct SettingsView: View {
    @State private var backendURL: String = (UserDefaults.standard.string(forKey: "backendURL") ?? "localhost:8080")
    
    var body: some View {
        let backendURLBinding = Binding<String>(get: {
            backendURL
        }, set: {
            backendURL = $0
            
            UserDefaults.standard.set(backendURL, forKey: "backendURL")
        })
        
        VStack(alignment: .center) {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
            
            TextField(
                "Backend URL",
                text: backendURLBinding
            )
            .frame(width: 200.0, height: 50.0)
            .textFieldStyle(.roundedBorder)
            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
