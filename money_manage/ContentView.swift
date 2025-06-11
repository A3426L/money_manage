//
//  ContentView.swift
//  money_manage
//
//  Created by aru on 2025/04/25.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab: Tab = .home
    var body: some View {
        Text("Hello, World!")
        TabView(selection: $selectedTab){
            AnalysisView()
                .tabItem{
                    Image(systemName: "1.circle.fill")
                        .font(.body)
                }
                .tag(Tab.analysis)
            MainView()
                .tabItem{
                    Image(systemName: "2.circle.fill")
                }
                .tag(Tab.home)
            ResisterView2()
                .tabItem{
                    Image(systemName: "3.circle.fill")
                }
                .tag(Tab.resister)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .accentColor(.blue)
        
        CustomTabbar(selectedTab: $selectedTab)
        
        

    }
}


#Preview {
    ContentView()
}
