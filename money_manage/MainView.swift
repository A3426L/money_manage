//
//  mainView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            Animation()
            HStack{
                Button(action: {
                    print("tap buton")
                }) {
                    Text("Button")
                }
            }
            Text("MainView")
        }
    }
}

#Preview {
    MainView()
}
