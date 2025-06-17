//
//  CustomCalender.swift
//  money_manage
//
//  Created by aru on 2025/05/19.
//

import SwiftUI
import SwiftData
import SwiftUICalendar

struct CustomCalender: View {
    var informations = [YearMonthDay: [(String, Color)]]()
    @Query(sort: \Transaction.date)  var transactions: [Transaction]

    init() {
        var date = YearMonthDay.current
//        print(date)
        informations[date] = []
        informations[date]?.append(("540", Color.red))

        date = date.addDay(value: 3)
        informations[date] = []
        informations[date]?.append(("400", Color.blue))
    }

    var body: some View {
        GeometryReader { reader in
            VStack {
                CalendarView(header: { week in
                    GeometryReader { geometry in
                        Text(week.shortString)
                            .font(.subheadline)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 2) {
                            if date.isToday {
                                Text("\(date.day)")
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(Color.red.opacity(0.95))
                                    .cornerRadius(14)
                            } else {
                                Text("\(date.day)")
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    .foregroundColor(getColor(date))
                                    .padding(4)
                            }
                            if let infos = informations[date] {
                                ForEach(infos.indices) { index in
                                    let info = infos[index]
                                    Text(info.0)
                                        .lineLimit(1)
                                        .foregroundColor(.white)
                                        .font(.system(size: 8, weight: .bold, design: .default))
                                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                        .frame(width: geometry.size.width, alignment: .center)
                                        .background(info.1.opacity(0.75))
                                        .cornerRadius(4)
                                        .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    }
                })
            }
            .onAppear {
                for tx in transactions {
                    print("Date: \(tx.date), Amount: \(tx.amount), Memo: \(tx.memo)")
                }
            }


        }
    }

    private func getColor(_ date: YearMonthDay) -> Color {
        if date.dayOfWeek == .sun {
            return Color.red
        } else if date.dayOfWeek == .sat {
            return Color.blue
        } else {
            return Color.black
        }
    }
}

#Preview {
    CustomCalender()
}
