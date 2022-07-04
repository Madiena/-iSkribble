//
//  ColorPicker.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 06.06.22.
//
// Code by Martin Mitrevski (https://github.com/martinmitrevski) file: https://github.com/martinmitrevski/DrawingPadSwiftUI/blob/master/DrawingPadSwiftUI/ColorPicker.swift


import SwiftUI

struct ColorPicker: View {
    @Binding var color: CGColor
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
        ColorPicker(color: .constant(CGColor(red: 0, green: 0, blue: 0, alpha: 0)), colorPickerShown: .constant(true))
    }
}
