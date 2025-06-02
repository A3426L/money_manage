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
    
    @State var displayText: String = ""
    @State var isYenAdded: Bool = false
    var body: some View {
        
        VStack{
            Animation(aligment: .topCenter)
            Text(displayText + (isYenAdded ? " 円" : ""))
            MoneyInputView(displayText: $displayText, isYenAdded: $isYenAdded)
                .frame(height: 500)

        }
    }
}

#Preview {
    ResisterView()
}
