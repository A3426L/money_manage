//
//  AnalysisView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI


struct AnalysisView: View {
    var body: some View {
        TabView{
            AnalysisPastView().tabItem{
                Label("Past", systemImage: "arrow.triangle.2.circlepath")
            }
            
            AnalysisFutureView().tabItem{
                Label("Future", systemImage: "arrow.triangle.2.circlepath")
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct AnalysisPastView: View {
    var body: some View {
        VStack{
            CustomCalender()
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
