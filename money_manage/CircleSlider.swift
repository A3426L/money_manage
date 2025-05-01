//
//  CircleSlider.swift
//  money_manage
//
//  Created by aru on 2025/04/26.
//

import Foundation
import SwiftUI

struct CircleSlider: View {
    @State var angle:CGFloat = 0
    @State var lastAngle:CGFloat = 0
    var radius:CGFloat
    let minValue: Double = 100
    let maxValue: Double = 10000
    var display_array = [1000,2000,3000,4000,5000]

    var body: some View {
                ZStack {
                    ZStack{
                        Circle()
                            .foregroundColor(Color.red.opacity(0.25))
                            .frame(width: radius, height: radius)
                        
                        ForEach(0..<5) { i in
                            let angle = Double(i) * .pi / 4.0
                            let tickX = (radius / 2) - (radius / 2) * cos(angle)
                            let tickY = (radius / 2) - (radius / 2) * sin(angle)
                            let label = Int(display_array[i])
                            
                            Text("¥\(label)")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .position(x: tickX, y: tickY + 10)
                        }
                    }
                    .rotationEffect(.degrees(self.angle))
                    .gesture(
                        DragGesture()
                         .onChanged{ drag in
                             let location = drag.location
                             let firstAngle = atan2(location.x - (radius / 2), (radius / 2) - location.y) * 180 / .pi
                             let newAngle = firstAngle + self.lastAngle
                             self.angle = min(max(newAngle, -90), 90)
                         }
                        .onEnded { drag in
                            self.lastAngle = self.angle
                        }
                     )
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .position(x: radius / 2, y: 0)
                }
                .frame(width: radius, height: radius)
                
                let clampedAngle = min(max(angle, -90), 90)
                let normalizedAngle = (clampedAngle + 90) / 180
                let index = Int(round((1 - normalizedAngle) * 4))
                let currentLabel = display_array[min(max(index, 0), display_array.count - 1)]

//                Text("選択中: ¥\(Int(currentLabel))")
//                    .font(.title)
            }
}

