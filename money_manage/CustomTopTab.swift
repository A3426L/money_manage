//
//  CustomTopTab.swift
//  money_manage
//
//  Created by aru on 2025/05/20.
//

import SwiftUI

enum TopTab{
    case past
    case future
}

struct CustomTopTab: View {
    @Binding var selectedTopTab: TopTab
    var body: some View {
        HStack{
            Button{
                print("past")
                selectedTopTab = .past
            }label: {
                Text("Past")
            }
            Button{
                print("future")
                selectedTopTab = .future
            }label: {
                Text("future")
                    
            }
        }
    }
    
}
