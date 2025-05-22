//
//  ResisterView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct ResisterView: View {
    @State var CurrentValue: String = ""
    @State var display_array = ["5000","2000","3000","4000","5000"]
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height + 80)
            Animation(aligment: .topCenter)
            ZStack{
                GridBackground(spacing: 20)
                VStack{
                    ZStack{
                        CircleSlider(CurrentValue: $CurrentValue, display_array: $display_array, radius: geometry.size.width + 120)
                                .position(center)
                                .onTapGesture {
                                    print($CurrentValue.wrappedValue)
                                }
                        
//                        CircleSlider(radius: geometry.size.width )
//                                .position(center)
//                        
//                        CircleSlider(radius: geometry.size.width - 120 )
//                                .position(center)

                    }
                }
            }
        }
    }
}

#Preview {
    ResisterView()
}
