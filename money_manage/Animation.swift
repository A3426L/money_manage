//
//  Animetion.swift
//  money_manage
//
//  Created by aru on 2025/05/01.
//

import SwiftUI
import RiveRuntime

struct Animation: View {
    var aligment: RiveAlignment = .center
    var fit:RiveFit = .contain
    
    var body: some View {
        VStack{
            RiveViewModel(fileName: "flora",fit: fit, alignment: aligment).view()
        }
    }
}

#Preview {
    Animation()
}
