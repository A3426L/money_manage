//
//  TestView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height + 100)
            Animation(aligment: .topCenter)
            ZStack{
                GridBackground(spacing: 20)
                VStack{
                    ZStack{
                        CircleSlider(radius: geometry.size.width + 200 )
                                .position(center)
                        CircleSlider(radius: geometry.size.width)
                                .position(center)
                    }
                }
            }
        }
    }
}

#Preview {
    TestView()
}
