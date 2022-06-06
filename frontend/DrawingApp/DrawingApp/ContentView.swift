//
//  ContentView.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI

struct Drawing {
    var points: [CGPoint] = [CGPoint]()
}


struct ContentView: View {
    @State private var currentDrawing: Drawing = Drawing()
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
        VStack(alignment: .center) {
        Text("Draw something!")
            .font(.largeTitle)
            .padding()
        DrawingPad(currentDrawing: $currentDrawing,
                drawings: $drawings,
                color: $color,
                lineWidth: $lineWidth)
        DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
