//
//  Numeric keypad.swift
//  money_manage
//
//  Created by aru on 2025/05/27.
//


import SwiftUI

enum KeypadButtonType: Hashable, Identifiable {
    case digit(Int)      // 数字 (0-9)
    case operation(String) // 演算子
    case clear           // クリア
    case thousands       // 千
    case onehundred      // 百
    case decimal         // 小数点 (.)
    case enter           // エンター
    case yen             // 円
    case delete          //一文字削除

    var id: String { description }

    var description: String {
        switch self {
        case .digit(let num): return "\(num)"
        case .operation(let op): return op
        case .clear: return "AC"
        case .thousands: return "千"
        case .onehundred: return "百"
        case .decimal: return "."
        case .enter: return "決定"
        case .yen: return "円"
        case .delete: return "削除"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .digit, .decimal:
            return Color(.systemGray5)
        case .operation:
            return .orange
        case .thousands, .onehundred, .yen:
            return Color(.systemGray3)
        case .enter:
            return Color(.systemGreen)
        case .clear:
            return Color(.systemRed)
        case .delete:
            return Color(.systemCyan)
        }
    }

    var foregroundColor: Color {
        switch self {
        case .operation, .enter, .clear, .yen, .thousands, .onehundred: // 背景が濃いボタンは白文字
            return .white
        default:
            return Color(.label)
        }
    }
}

// 個々のボタンのView (再利用のため)
struct KeypadButtonView: View {
    let type: KeypadButtonType
    let height: CGFloat
    let width: CGFloat
    let action: (KeypadButtonType) -> Void

    var body: some View {
        Button(action: {
            action(type)
        }) {
            Text(type.description)
                .font(.system(size: height * 0.4, weight: .medium)) // フォントサイズ調整
                .frame(width: width, height: height)
                .background(type.backgroundColor)
                .foregroundColor(type.foregroundColor)
                .cornerRadius(height / 3)
                .contentShape(Rectangle())
        }
    }
}


struct CalculatorKeypadView: View {
    var onButtonTap: (KeypadButtonType) -> Void

    let mainButtonLayout: [[KeypadButtonType]] = [
        [.digit(7), .digit(8), .digit(9)],
        [.digit(4), .digit(5), .digit(6)],
        [.digit(1), .digit(2), .digit(3)],
        [.clear, .digit(0), .delete],
        [.thousands, .onehundred, .enter]
    ]

    var body: some View {
        GeometryReader { geometry in
            let buttonSpacing: CGFloat = 10
            let totalHorizontalSpacing = buttonSpacing * 2
            let horizontalPadding: CGFloat = buttonSpacing * 2
            let buttonWidth = (geometry.size.width - totalHorizontalSpacing - horizontalPadding) / 3
            
            let totalVerticalSpacing = buttonSpacing * (CGFloat(mainButtonLayout.count) + 1)
            let buttonHeight = max(20, (geometry.size.height - totalVerticalSpacing) / CGFloat(mainButtonLayout.count))


            VStack(spacing: buttonSpacing) {
                ForEach(mainButtonLayout, id: \.self) { row in
                    HStack(spacing: buttonSpacing) {
                        ForEach(row, id: \.self) { buttonType in
                            KeypadButtonView(type: buttonType, height: buttonHeight, width: buttonWidth, action: onButtonTap)
                        }
                    }
                }
            }
            .padding(buttonSpacing)
        }
    }
}

struct MoneyInputView: View {
    @Binding var displayText: String
    @Binding var isYenAdded: Bool
    @State private var keypadHeightRatio: CGFloat = 0.55

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()

                CalculatorKeypadView { buttonType in
                    handleButtonTap(buttonType)
                }
                .frame(height: geometry.size.height * keypadHeightRatio)
            }
            .edgesIgnoringSafeArea(.bottom)
        }

    }

    private func handleButtonTap(_ buttonType: KeypadButtonType) {
        if isYenAdded && buttonType != .clear {
            if buttonType == .enter {
                print("最終金額確定: \(displayText) 円")
            }
            return
        }

        switch buttonType {
        case .digit(let number):
            let currentNumbers = displayText.filter { "0123456789".contains($0) }
            if currentNumbers.count >= 10 && displayText != "0" { return }

            if displayText == "0" {
                displayText = "\(number)"
            } else {
                displayText += "\(number)"
            }
        case .decimal:
            if !displayText.contains(".") {
                displayText += "."
            }
        case .clear:
            displayText = "0"
            isYenAdded = false
        case .thousands:
            applyMultiplier(value: 1000, baseSuffix: "000")
        case .onehundred:
            applyMultiplier(value: 100, baseSuffix: "00")
        case .yen:
            if !displayText.isEmpty && displayText != "0" {
                isYenAdded = true
            }
        case .enter:
            print("入力内容: \(displayText)")
            if !isYenAdded && !displayText.isEmpty && displayText != "0" {
                 isYenAdded = true
            }
            // ここでdbに保存などの処理する！！
            
        case .operation:
            print("Operation button tapped, but not implemented for money input.")
            break
            
        case .delete:
            print("delete")
            if !displayText.isEmpty {
                displayText.removeLast()
            }
            break
        }
    }

    private func applyMultiplier(value: Int, baseSuffix: String) {
        if isYenAdded { return }

        var currentStringValue = displayText
        if let dotIndex = currentStringValue.firstIndex(of: ".") {
            currentStringValue = String(currentStringValue[..<dotIndex])
        }
        let multiplierAsDecimal = NSDecimalNumber(value: value)

        if currentStringValue == "0" || currentStringValue.isEmpty {
            displayText = multiplierAsDecimal.stringValue // 非オプショナルなので直接使用
        } else {
            let currentNumbersCount = currentStringValue.filter { "0123456789".contains($0) }.count
            if currentNumbersCount > (10 - baseSuffix.count) {
                print("桁数オーバーのため操作できません")
                return
            }
            
            let potentialDecimal: NSDecimalNumber? = NSDecimalNumber(string: currentStringValue)
            if let currentValueDecimal = potentialDecimal {
                
                displayText = currentValueDecimal.multiplying(by: multiplierAsDecimal).stringValue
            } else {
                print("Error: Could not convert '\(currentStringValue)' to NSDecimalNumber.")
            }
        }
    }
}

