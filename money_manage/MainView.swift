//
//  mainView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct MainView: View {
    @State private var text:String = "Hello!"
    @State private var textlines:[String] = ["こんにちは！","今日はいい天気ですね。","hahaha"]
    @State private var currentIndex:Int = 0
    var body: some View {
        VStack{
            Animation(aligment: .topCenter, fit:.contain)
                .frame(height: 300)
                .border(Color.blue)
            Text(textlines[currentIndex])
                .font(.largeTitle)
                .frame(height: 100, alignment: .leading)
                .frame(maxWidth: .infinity)
                .border(Color.black)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(12)
                .padding()
                .onTapGesture {
                    if currentIndex < textlines.count - 1 {
                        currentIndex += 1
                    }
                }
            Spacer()
            Grid{
                GridRow{
                    Button {
                        currentIndex = 0
                        textlines = ["一週間の予測を伝えるよ！","今週はあんま良くないよ","もっと頑張れよてめえ"]
                    } label: {
                        Text("一週間の予測")
                    }
                    .padding()
                    .accentColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(.infinity)
                    .shadow(color: Color.black, radius: 0, x: 0, y: 5)
                    
                    Button {
                        currentIndex = 0
                        textlines = ["明日の予測を教えるよ！","明日は5,000円使うらしいで","程々にしとけよワレ"]
                    } label: {
                        Text("明日の予測")
                    }
                    .padding()
                    .accentColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(.infinity)
                    .shadow(color: Color.black, radius: 0, x: 0, y: 6)
                }
                GridRow{
                    Button {
                        currentIndex = 0
                        textlines = ["お話し？","舐めてんのか？","暇人が!働け！"]
                    } label: {
                        Text("お話ししよ〜")
                    }
                    .padding()
                    .accentColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(.infinity)
                    .shadow(color: Color.black, radius: 0, x: 0, y: 5)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .border(Color.green)
        }
    }
}

#Preview {
    MainView()
}
