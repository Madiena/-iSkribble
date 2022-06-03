//
//  DrawingControls.swift
//  DrawingApp
//
//  Created by Lothar Hestermann on 30.05.22.
//

import SwiftUI

struct DrawingControls: View {
    @State private var colorPickerShown: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: spacing){
                    Button("Pick color") {
                        self.colorPickerShown = true
                    }
                    Button("Undo") {
                        if self.drawings.count > 0 {
                            self.drawings.removeLast()
                        }
                    }
                    Button("Clear") {
                        self.drawings = [Drawing]()
                    }
                }
                HStack {
                    Text("Pencil width")
                        .padding()
                    Slider(value: $lineWidth, from: 1.0, through: 15.0, by: 1.0)
                        .padding()
                }
            }
        }
        .frame(height: 200)
        .sheet(isPresented: $colorPickerShown, onDismiss: {
            self.colorPickerShown = false
        }, content: { () -> ColorPicker in
            ColorPicker(color: self.$color, colorPickerShown: self.$colorPickerShown)
        })
    }
}

struct DrawingControls_Previews: PreviewProvider {
    static var previews: some View {
        DrawingControls()
    }
}
