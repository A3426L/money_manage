//
//  ResisterView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct ResisterView: View {
    @State var currentValue: Double = 5000
    @State var currentValue2: Double = 500
    @State var display_array = ["1000","2000","3000","4000","5000","6000","7000","8000","9000","10000"]
    var body: some View {
        
//        GeometryReader { geometry in
//            let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height + 80)
//            Animation(aligment: .topCenter)
//        }
        VStack{
            Animation(aligment: .topCenter)
            
            ZStack{
                CircularPicker(value: $currentValue,
                               minValue: 0.0,
                               maxValue: 10000,
                               tickCount: 11,
                               minorTicksPerMajor: 0,
                               stepValue: 1000)
                .frame(width: 400, height: 500)
                CircularPicker(value: $currentValue2,
                               minValue: 0.0,
                               maxValue: 1000,
                               tickCount: 11,
                               minorTicksPerMajor: 0,
                               stepValue: 100)
                .frame(width: 200, height: 200)
                
                Text(String(Int(currentValue + currentValue2)))
   
            }
            .frame(width: 400,height: 50)

        }
    }
}

#Preview {
    ResisterView()
}
