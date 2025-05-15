//
//  ContentView.swift
//  money_manage
//
//  Created by aru on 2025/04/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        TabView{
            AnalysisView()
                .tabItem{
                    Image(systemName: "1.circle.fill")
                }
            MainView()
                .tabItem{
                    Image(systemName: "2.circle.fill")
                }
            ResisterView()
                .tabItem{
                    Image(systemName: "3.circle.fill")
                }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

    }
}


#Preview {
    ContentView()
}
