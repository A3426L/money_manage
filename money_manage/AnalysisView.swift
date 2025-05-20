//
//  AnalysisView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI


struct AnalysisView: View {
    @State var TopTabSelected:TopTab = .past
    var body: some View {
        VStack{
            CustomTopTab(selectedTopTab: $TopTabSelected)
            TabView(selection: $TopTabSelected){
                AnalysisPastView()
                    .tag(TopTab.past)
                
                AnalysisFutureView()
                    .tag(TopTab.future)
            }
            .disabled(true)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
        }

    }
}

struct AnalysisPastView: View {
    var body: some View {
        VStack{
            CustomCalender()
                .padding()
            ScrollView{
                CustomCharts()
                LineMarkGraphView()
            }
        }
    }
}

struct AnalysisFutureView: View {
    var body: some View {
        Text("AnalysisFutureView")
    }
}

struct BasicMultiDatePicker: View {
 
    @State private var dates: Set<DateComponents> = []

    var body: some View {
        MultiDatePicker("複数の日付選択", selection: $dates)
            .frame(maxWidth: .infinity, maxHeight: 0,alignment: .bottom)
    }
}

#Preview {
    AnalysisView()
}
