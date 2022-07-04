//
//  DrawingControls.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//
//  Original code idea by Martin Mitrevski (https://github.com/martinmitrevski) file: https://github.com/martinmitrevski/DrawingPadSwiftUI/blob/master/DrawingPadSwiftUI/DrawingControls.swift

import SwiftUI
import shared

struct DrawingControls: View {
    @EnvironmentObject var gameManager: GameManager
    
    @State private var colorPickerShown: Bool = false
    @Binding var drawingsControlsShown: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 40){
                    Button("Pick color") {
                        self.colorPickerShown = true
                    }
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Button("Undo") {
                        gameManager.undoDrawing()
                    }
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Button("Clear") {
                        gameManager.clearCanvas()
                    }
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Button(action: { drawingsControlsShown = false
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                }
                HStack {
                    Text("Pencil width")
                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        .padding()
                    Slider(value: $gameManager.currentDrawing.lineWidth, in: 1.0...15.0, step: 1.0)
                        .tint(Color(red: 0.7, green: 0.7, blue: 0.9))
                        .padding()
                }
            }
        }
        .frame(height: 200)
        .sheet(isPresented: $colorPickerShown, onDismiss: {
            self.colorPickerShown = false
        }, content: { () -> ColorPicker in
            ColorPicker(
                color: $gameManager.currentDrawing.color,
                colorPickerShown: self.$colorPickerShown
            )
        })
    }
}

struct DrawingControls_Previews: PreviewProvider {
    static var previews: some View {
        DrawingControls(drawingsControlsShown: .constant(true))
            .environmentObject(GameManager())
    }
}
