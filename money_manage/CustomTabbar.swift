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
                        selectedTab = .analysis
                    } label: {
                        Image(systemName: "calendar.and.person")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    
                    Button {
                        selectedTab = .home
                    } label: {
                        Image(systemName: "house")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    Button {
                        selectedTab = .resister
                    } label: {
                        Image(systemName: "fleuron")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
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
