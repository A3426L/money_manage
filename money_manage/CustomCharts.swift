//
//  CustomCharts.swift
//  money_manage
//
//  Created by aru on 2025/05/19.
//

import SwiftUI
import Charts

struct FavoriteFruit {
    let name: String
    let count: Int
}

struct CustomCharts: View {
    @State private var money_categories: [FavoriteFruit] = [
        .init(name: "食費", count: 15),
        .init(name: "日用品", count: 12),
        .init(name: "交際費", count: 6),
        .init(name: "なんか１", count: 5),
        .init(name: "なんか２", count: 4),
        .init(name: "なんか３", count: 2)
    ]
    var body: some View {
        Chart(money_categories, id: \.name) { moneyCategory in
            if #available(iOS 17.0, *) {
                SectorMark(
                    angle: .value("count", moneyCategory.count)
                )
                .foregroundStyle(by: .value("name", moneyCategory.name))
            } else {
                
            }
        }
        .frame(width: 300, height: 300)
    }
}
struct MoneyData {
    let day: Int
    let forcast: Double
    let result: Double
}

struct LineMarkGraphView: View {
    @State private var data: [MoneyData] = [
        .init(day: 1, forcast: 1500, result: 1300),
        .init(day: 2, forcast: 1600, result: 1000),
        .init(day: 3, forcast: 1700, result: 1100),
        .init(day: 4, forcast: 1600, result: 1100),
        .init(day: 5, forcast: 1200, result: 1200),
        .init(day: 6, forcast: 1200, result: 1300),
        .init(day: 7, forcast: 1100, result: 1500),
        .init(day: 8, forcast: 900, result: 900),
        .init(day: 9, forcast: 950, result: 1000),
        .init(day: 10, forcast: 1000, result: 1000),
    ]
    
    var body: some View {
        Chart {
            ForEach(data, id: \.day) { MoneyData in
                LineMark(
                    x: .value("day", MoneyData.day),
                    y: .value("result", MoneyData.result)
                )
                .foregroundStyle(by: .value("result", "実績"))
                
                LineMark(
                    x: .value("day", MoneyData.day),
                    y: .value("forcast", MoneyData.forcast)
                )
                .foregroundStyle(by: .value("forcast", "予測"))
            }
        }
        .chartForegroundStyleScale(["実績": Color.orange, "予測": Color.cyan])
        .frame(width: 300, height: 500)
    }
}

#Preview {
//    CustomCharts()
    LineMarkGraphView()
}
