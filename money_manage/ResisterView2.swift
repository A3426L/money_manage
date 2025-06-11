//
//  ResisterView2.swift
//  money_manage
//
//  Created by aru on 2025/06/11.
//

import SwiftUI

struct ResisterView2: View {
    @State private var isSheetPresented = false
    var body: some View {
        
        VStack{
            Animation(aligment: .topCenter)
            Button("メニューを開く") {
                isSheetPresented = true
            }
            .font(.title2)
            .padding()
            .sheet(isPresented: $isSheetPresented) {
                AddExpenseView()
                     .presentationDetents([.medium, .large])
                     .presentationDragIndicator(.visible)
            }
        }

        
    }
    
}


struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCategory = "Food"
    @State private var amount = ""
    @State private var date = Date()
    @State private var memo = ""
    
    let categories = ["Food", "Transport", "Hobbies", "Shopping", "Other"]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            VStack(alignment: .leading, spacing: 8){
                Text("Category")
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categories, id: \.self) { category in
                        VStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .overlay(Image(systemName: iconName(for: category))
                                    .foregroundColor(.white))
                            Text(category)
                                .font(.caption)
                                .foregroundColor(selectedCategory == category ? .black : .gray)
                        }
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 8){
                Text("Money")
                    .fontWeight(.bold)
                
                TextField("¥0", text: $amount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
        
            VStack(alignment: .leading, spacing: 8) {
                Text("Memo")
                    .fontWeight(.bold)
                
                TextField("memo", text: $memo)
                    .keyboardType(.webSearch)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            
            HStack(alignment: .center, spacing: 20){
                VStack(alignment: .leading, spacing: 3) {
                    Text("Date")
                        .fontWeight(.bold)
                    
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .padding()
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                Button("決定"){
                    print("決定")
                }
                .frame(minWidth: 30, maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding(.horizontal)


            
            Spacer()
        }
        .padding(.top)
        .background(Color.white.ignoresSafeArea())
    }
    
    func iconName(for category: String) -> String {
        switch category {
        case "Food": return "fork.knife"
        case "Transport": return "car.fill"
        case "Hobbies": return "gamecontroller.fill"
        case "Shopping": return "bag.fill"
        default: return "questionmark.circle"
        }
    }
}


#Preview {
    ResisterView2()
}
