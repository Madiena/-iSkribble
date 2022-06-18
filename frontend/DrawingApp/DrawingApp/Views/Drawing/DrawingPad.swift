//
//  DrawingPad.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//

import SwiftUI
import shared

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
                
                drawings.append(self.currentDrawing)
                
                currentDrawing.path = []
            })
        )
    }

    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.path
        if points.count > 1 {
            path.move(to: points[0])
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
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
