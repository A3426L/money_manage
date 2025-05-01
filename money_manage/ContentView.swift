//
//  ContentView.swift
//  money_manage
//
//  Created by aru on 2025/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height + 100)
            Animation()
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
    ContentView()
}
