//
//  DrawingControlsButtonView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 20.06.22.
//

import SwiftUI

struct DrawingControlsButtonView: View {
    @State var drawingControlsShown: Bool
    @EnvironmentObject var gameManager: GameManager
    
    @State var color: Color
    @State var lineWidth: CGFloat
    
    
    var body: some View {
        Button(action: {
            drawingControlsShown = true
        })
        {
            Image(systemName: "pencil.tip.crop.circle")
                .font(.system(size: 50))
                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.9))
        }
        .sheet(isPresented: $drawingControlsShown) {
            DrawingControls(color: $color, lineWidth: $lineWidth)
        }
    }
}

struct DrawingControlsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingControlsButtonView(drawingControlsShown: false, color: Color.black, lineWidth: 3.0).environmentObject(GameManager())
    }
}
