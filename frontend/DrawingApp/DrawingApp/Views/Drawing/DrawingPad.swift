//
//  DrawingPad.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI
import shared

struct DrawingPad: View {
    @EnvironmentObject var gameManager: GameManager
    
    @Binding var currentDrawing: Drawing
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    
    var body: some View {
        Canvas { context, size in
            for drawing in gameManager.gameData?.imageData ?? [] {
                context.stroke(
                    Path { path in
                        self.add(drawing: drawing, toPath: &path)
                    },
                    with: .color(drawing.color),
                    style: StrokeStyle(
                        lineWidth: drawing.lineWidth,
                        lineCap: .round
                    )
                )
                
            }
            
            context.stroke(
                Path { path in
                    self.add(drawing: currentDrawing, toPath: &path)
                },
                with: .color(color),
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round
                )
            )
        }
        .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .gesture(
            DragGesture(minimumDistance: 0.1)
                .onChanged({ (value) in
                    let currentPoint = value.location
                    self.currentDrawing.path.append(currentPoint)
                    
                })
                .onEnded({ (value) in
                    currentDrawing.lineWidth = lineWidth
                    currentDrawing.color = color
                    
                    gameManager.sendDrawing(currentDrawing)
                    
                    currentDrawing.path = []
                })
        )
    }
    
    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.path
        if points.count > 1 {
            path.move(to: points[0])
            for i in 1..<points.count {
                path.addLine(to: points[i])
            }
        }
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPad(
            currentDrawing: .constant(Drawing(color: Color.black, lineWidth: 3.0)),
            color: .constant(Color.black),
            lineWidth: .constant(3)
        )
    }
}
