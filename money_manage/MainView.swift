//
//  mainView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//

import SwiftUI

struct MainView: View {
    @State private var text:String = "Hello!"
    @State var currentIndex: Int = 0
    @State var textlines: [String] = ["一週間の予測を伝えるよ！","今週はあんま良くないよ","もっと頑張ろう"]
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
            Spacer()
            
            Grid(alignment: .bottom,horizontalSpacing: 50, verticalSpacing: 10){
                GridRow{
                    CustomButton(label: "一週間の予測",action: {
                        currentIndex = 0
                        textlines = ["一週間の予測を伝えるよ！","今週はあんま良くないよ","もっと頑張ってね"]
                    })
                    
                    CustomButton(label: "明日の予測",action: {
                        currentIndex = 0
                        textlines = ["明日の予測を教えるよ！","明日は5,000円使うらしいで","程々にね"]
                    })
                }
                
                GridRow{
                    CustomButton(label: "お話ししよ〜",action: {
                        currentIndex = 0
                        textlines = ["お話し？","舐めてんのか？","暇人が!働け！"]
                    })
                }
            }
            .frame(maxWidth: .infinity)
            .border(Color.green)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            if currentIndex < textlines.count - 1 {
                currentIndex += 1
            }
        }
    }
}

#Preview {
    MainView()
}
