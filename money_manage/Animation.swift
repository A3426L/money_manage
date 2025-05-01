//
//  Animetion.swift
//  money_manage
//
//  Created by aru on 2025/05/01.
//

import SwiftUI
import RiveRuntime

struct Animation: View {
    var body: some View {
        RiveViewModel(fileName: "flora").view()
    }
}

#Preview {
    Animation()
}
