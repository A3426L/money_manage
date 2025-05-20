//
//  CustomTabbar.swift
//  money_manage
//
//  Created by aru on 2025/05/16.
//

import SwiftUI


enum Tab {
    case home
    case analysis
    case resister
}
    
struct CustomTabbar: View {
    @Binding var selectedTab: Tab
    var body: some View {
            ZStack{
                HStack{
                    Spacer()
                    Button {
                        print("1")
                        selectedTab = .analysis
                    } label: {
                        Text("1")
                    }
                    .frame(width: 80,height: 60)
                    .background(.black)
                    Spacer()
                    
                    Button {
                        print("2")
                        selectedTab = .home
                        print(selectedTab)
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
                        selectedTab = .resister
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

struct CustomTabItem: View{
    var body: some View{
        Text("Custom")
    }
}

#Preview {
    @State var selectedTab: Tab = .home
    return CustomTabbar(selectedTab: $selectedTab)
}
