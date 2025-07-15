//
//  CustomTalkButtons.swift
//  money_manage
//
//  Created by aru on 2025/07/15.
//

import SwiftUI

struct CustomTalkButtons: View {
    @State private var templates: ChatTemplates? = nil
    @State var currentIndex: Int = 0
    @State var textlines: [String] = ["一週間の予測を伝えるよ！","今週はあんま良くないよ","もっと頑張ろう"]
    var body: some View {
        VStack{
            Text(textlines[currentIndex])
                .font(.body)
                .frame(height: 100, alignment: .leading)
                .frame(maxWidth: .infinity)
                .border(Color.black, width: 5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding()
            
            Spacer()
            
            Grid(alignment: .bottom,horizontalSpacing: 50, verticalSpacing: 10){
                GridRow{
                    CustomButton(label: "一週間の予測",action: {
                        if let lines = templates?.weekly_spending_forecast.randomElement() {
                            currentIndex = 0
                            textlines = lines
                        }
                    })
                    
                    CustomButton(label: "明日の予測",action: {
                        if let lines = templates?.tomorrow_forecast.randomElement() {
                            currentIndex = 0
                            textlines = lines
                        }
                    })
                }
                
                GridRow{
                    CustomButton(label: "お話ししよ〜",action: {
                        if let lines = templates?.chitchat.randomElement() {
                            currentIndex = 0
                            textlines = lines
                        }
                    })
                    
                    CustomButton(label: "アドバイス",action: {
                        if let lines = templates?.advice.randomElement() {
                            currentIndex = 0
                            textlines = lines
                        }
                    })
                    
                }
                
                GridRow{
                    CustomButton(label: "送信1") {
                        let url = URL(string: "http://192.168.0.100:5001/predict")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET"
                        
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            if let data = data, let text = String(data: data, encoding: .utf8) {
                                print("レスポンス: \(text)")
                            }
                        }
                        task.resume()
                    }
                    CustomButton(label: "送信2") {
                        let url = URL(string: "http://192.168.0.100:5002/predict")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET"
                        
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            if let data = data, let text = String(data: data, encoding: .utf8) {
                                print("レスポンス: \(text)")
                            }
                        }
                        task.resume()
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            if currentIndex < textlines.count - 1 {
                currentIndex += 1
            }
        }
        .onAppear {
            templates = loadChatTemplates()
        }
    }
}

#Preview {
    CustomTalkButtons()
}
