//
//  mainView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct MainView: View {
    @State private var text:String = "Hello!"
    var body: some View {
        VStack{
            Animation(aligment: .topCenter, fit:.contain)
                .frame(height: 300)
                .border(Color.blue)
            Chat()
        }
    }
}

#Preview {
    MainView()
}
