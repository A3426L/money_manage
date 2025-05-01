//
//  Grid.swift
//  money_manage
//
//  Created by aru on 2025/04/28.
//

import SwiftUI

struct GridBackground: View {
    var spacing: CGFloat = 20
    var color: Color = .gray.opacity(0.3)

    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let columns = Int(size.width / spacing)
                let rows = Int(size.height / spacing)
                
                for i in 0...columns {
                    let x = CGFloat(i) * spacing
                    var path = Path()
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                    context.stroke(path, with: .color(color), lineWidth: 0.5)
                }
                
                for j in 0...rows {
                    let y = CGFloat(j) * spacing
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                    context.stroke(path, with: .color(color), lineWidth: 0.5)
                }
            }
        }
    }
}
