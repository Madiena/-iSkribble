//
//  DrawingPad.swift
//  DrawingApp
//
//  Created by Madelaine Hestermann on 30.05.22.
//
// Original code idea by Martin Mitrevski (https://github.com/martinmitrevski) file: https://github.com/martinmitrevski/DrawingPadSwiftUI/blob/master/DrawingPadSwiftUI/DrawingPad.swift

import SwiftUI
import shared

struct DrawingPad: View {
    @EnvironmentObject var gameManager: GameManager
    
    private let canvasSize = CGSize(
        width: 500,
        height: 500
    )
    
    var body: some View {
        GeometryReader { proxy in
            Canvas { context, size in
                let scaledSize = scaleSize(size)
                context.scaleBy(x: scaledSize.width, y: scaledSize.height)
                
                for drawing in gameManager.gameData?.imageData ?? [] {
                    context.stroke(
                        Path { path in
                            self.add(drawing: drawing, toPath: &path)
                        },
                        with: .color(Color(drawing.color)),
                        style: StrokeStyle(
                            lineWidth: drawing.lineWidth,
                            lineCap: .round
                        )
                    )
                    
                }
                
                context.stroke(
                    Path { path in
                        self.add(drawing: gameManager.currentDrawing, toPath: &path)
                    },
                    with: .color(Color(gameManager.currentDrawing.color)),
                    style: StrokeStyle(
                        lineWidth: gameManager.currentDrawing.lineWidth,
                        lineCap: .round
                    )
                )
            }
            //.frame(maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged({ (value) in
                        let currentPoint = scalePoint(
                            proxy.size,
                            point: value.location
                        )
                        gameManager.currentDrawing.path.append(currentPoint)
                        
                    })
                    .onEnded({ (value) in
                        gameManager.sendDrawing()
                        
                        gameManager.currentDrawing.path = []
                    }),
                including: gameManager.ownUserIsDrawing ? .all : .none
            )
        }
    }
    
    private func scaleSize(_ sizeToScale: CGSize) -> CGSize {
        return CGSize(width: sizeToScale.width / canvasSize.width, height: sizeToScale.height / canvasSize.height)
    }
    
    private func scalePoint(_ canvasSize: CGSize, point: CGPoint) -> CGPoint {
        let canvasDelta = scaleSize(canvasSize)
        return CGPoint(x: point.x / canvasDelta.width, y: point.y / canvasDelta.height)
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
        DrawingPad()
            .environmentObject(GameManager())
    }
}
