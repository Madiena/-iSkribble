//
//  DrawingPad.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI

struct DrawingPad: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    
    var body: some View {
        Canvas { context, size in
            
            for drawing in drawings {
                context.stroke(
                    Path { path in
                        self.add(drawing: drawing, toPath: &path)
                    },
                    with: .color(drawing.color),
                    lineWidth: drawing.lineWidth
                )

            }
            
            context.stroke(
                Path { path in
                    self.add(drawing: currentDrawing, toPath: &path)
                },
                with: .color(color),
                lineWidth: lineWidth
            )
        }
        .frame(maxHeight: .infinity)
        .gesture(
        DragGesture(minimumDistance: 0.1)
            .onChanged({ (value) in
                let currentPoint = value.location
                    self.currentDrawing.points.append(currentPoint)
                
            })
            .onEnded({ (value) in
                currentDrawing.lineWidth = lineWidth
                currentDrawing.color = color
                self.drawings.append(self.currentDrawing)
                self.currentDrawing = Drawing(color: color, lineWidth: lineWidth)
            })
        )
    }
    
    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPad(currentDrawing: .constant(Drawing(color: Color.black, lineWidth: 3.0)), drawings: .constant([Drawing]()), color: .constant(Color.black), lineWidth: .constant(3))
    }
}
