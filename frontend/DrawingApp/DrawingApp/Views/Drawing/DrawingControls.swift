//
//  DrawingControls.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI
import shared

struct DrawingControls: View {
    @Binding var color: Color
    @Binding var drawings: [Drawing]
    @Binding var lineWidth: CGFloat
    
    @State private var colorPickerShown: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 40){
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
                    Slider(value: $lineWidth, in: 1.0...15.0, step: 1.0)
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
        DrawingControls(color: .constant(Color.black), drawings: .constant([Drawing]()), lineWidth: .constant(3))
    }
}
