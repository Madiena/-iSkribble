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
    
    var body: some View {
        Canvas { context, size in
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
        .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .gesture(
            DragGesture(minimumDistance: 0.1)
                .onChanged({ (value) in
                    let currentPoint = value.location
                    gameManager.currentDrawing.path.append(currentPoint)
                    
                })
                .onEnded({ (value) in
                    gameManager.sendDrawing()
                    
                    gameManager.currentDrawing.path = []
                }),
            including: gameManager.ownUserIsDrawing ? .all : .none
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
        DrawingPad()
            .environmentObject(GameManager())
    }
}
