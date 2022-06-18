//
//  ColorPicker.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 06.06.22.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var color: Color
    @Binding var colorPickerShown: Bool
    
    private let colors = ColorsProvider.supportedColors()
    
    var body: some View {
        List(colors) { colorInfo in
            ColorEntry(colorInfo: colorInfo).onTapGesture {
                self.color = colorInfo.color
                self.colorPickerShown = false
            }
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
  
    static var previews: some View {
        ColorPicker(color: .constant(Color.black), colorPickerShown: .constant(true))
    }
}
