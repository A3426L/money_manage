//
//  CustomTabbar.swift
//  money_manage
//
//  Created by aru on 2025/05/16.
//

import SwiftUI

struct CustomTabbar: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        Text("test")
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                AnalysisView()
                    .tabItem{
                        Image(systemName: "1.circle.fill")
                            .font(.body)
                    }
                    .tag(1)
                MainView()
                    .tabItem{
                        Image(systemName: "2.circle.fill")
                    }
                    .tag(2)
                ResisterView()
                    .tabItem{
                        Image(systemName: "3.circle.fill")
                    }
                    .tag(3)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            ZStack{
                HStack{
                    Spacer()
                    Button {
                        print("1")
                        selectedTab = 1
                    } label: {
                        Text("1")
                    }
                    .frame(width: 80,height: 60)
                    .background(.black)
                    Spacer()
                    
                    Button {
                        print("2")
                        selectedTab = 2
                    } label: {
                        Text("2")
                            .frame(width: 80,height: 60)
                            .foregroundColor(.white)
                    }
                    .frame(width: 80,height: 60)
                    .background(.black)
                    
                    Spacer()
                    Button {
                        print("3")
                        selectedTab = 3
                    } label: {
                        Text("3")
                    }
                    .frame(width: 80,height: 60)
                    .background(.black)
                    Spacer()
                }
                .padding(8)
            }
        }
    }
    
}

#Preview {
    CustomTabbar()
}
