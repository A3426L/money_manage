//
//  CirclePicker.swift
//  money_manage
//
//  Created by aru on 2025/05/26.
//

import SwiftUI

struct CircularPicker: View {
    @Binding var value: Double
    let minValue: Double
    let maxValue: Double
    let tickCount: Int // 主目盛りの数 (例: 0から10まで1刻みなら11)
    let minorTicksPerMajor: Int // 主目盛り間の副目盛りの数
    let displayArcAngle: Angle // 目盛りが表示される円弧の角度 (例: 180度)
    let stepValue:Double //取得する値の間隔

    // ドラッグ操作の開始値を保持するための状態変数
    @State private var dragStartValue: Double? = nil
    @State private var dragStartTouchAngle: CGFloat? = nil // ドラッグ開始時のタッチ角度（ビュー座標系）

    private var valueRange: Double {
        max(0.0001, maxValue - minValue) // 0除算を避ける
    }

    private var valuePerRadian: Double {
        valueRange / displayArcAngle.radians
    }
    
    private var effectiveStepBounds: (min: Double, max: Double) {
        // ceil と floor をグローバル関数として呼び出す
        let minStepped = ceil(self.minValue / self.stepValue) * self.stepValue
        let maxStepped = floor(self.maxValue / self.stepValue) * self.stepValue
        
        if minStepped > maxStepped {
            // 有効なステップが範囲内にない場合 (例: min=100, max=800, step=1000)
            // ピッカーは minStepped の値 (例: 1000) にスナップし、その値で固定される
            return (minStepped, minStepped)
        }
        return (minStepped, maxStepped)
    }

    init(value: Binding<Double>,
         minValue: Double = 0.0,
         maxValue: Double = 10000, // 画像の7.0が中央であることから推測
         tickCount: Int = 11,     // 0, 1.4, ..., 14.0 の場合11個の主目盛り
         minorTicksPerMajor: Int = 3, // 画像から主目盛り間に3つの副目盛り
         displayArcAngle: Angle = .degrees(180),
        stepValue : Double = 1000
    ) {
        self._value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.tickCount = tickCount
        self.minorTicksPerMajor = minorTicksPerMajor
        self.displayArcAngle = displayArcAngle
        self.stepValue = stepValue
    }

    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width / 2, geometry.size.height) * 0.85
            // ピッカーの円弧の中心。赤いインジケーターが上に来るように調整
            let arcCenter = CGPoint(x: geometry.size.width / 2,
                                    y: geometry.size.height * 0.2 + radius ) // 上部20%の位置 + 半径

            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                TicksView(
                    minValue: minValue,
                    maxValue: maxValue,
                    tickCount: tickCount,
                    minorTicksPerMajor: minorTicksPerMajor,
                    radius: radius,
                    arcCenter: arcCenter,
                    displayArcAngle: displayArcAngle
                )
                .rotationEffect(calculateRotationForValue(self.value), anchor: .init(x: arcCenter.x / geometry.size.width, y: arcCenter.y / geometry.size.height))


                // 中央の赤いインジケーター
                Path { path in
                    let indicatorTopY = arcCenter.y - radius
                    path.move(to: CGPoint(x: arcCenter.x, y: indicatorTopY - 5))
                    path.addLine(to: CGPoint(x: arcCenter.x, y: indicatorTopY + 15))
                }
                .stroke(Color.red, lineWidth: 2.5)

                // 現在の値のテキスト表示
                Text(String(format: "%.f", abs(value)))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .position(x: arcCenter.x, y: arcCenter.y - radius + 35)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gestureValue in
                        let touchLocation = gestureValue.location
                        let dx = touchLocation.x - arcCenter.x
                        let dy = touchLocation.y - arcCenter.y
                        let currentTouchAngle = atan2(dx, -dy)

                        if dragStartValue == nil {
                            dragStartValue = self.value
                            dragStartTouchAngle = currentTouchAngle
                        }
                        
                        guard let currentDragStartValue = self.dragStartValue,
                        let currentDragStartTouchAngle = self.dragStartTouchAngle else {
                            return
                        }
                        
                        var angleDelta = currentTouchAngle - dragStartTouchAngle!
                        // 角度の差を -π から π の範囲に正規化
                        if angleDelta > .pi { angleDelta -= 2 * .pi }
                        if angleDelta < -.pi { angleDelta += 2 * .pi }
                        
                        // 時計回りのドラッグ（angleDeltaが正）で値が減少するように調整
//                        let newValue = dragStartValue! - (angleDelta * valuePerRadian)
//                        self.value = max(minValue, min(maxValue, newValue))
                        
                        let provisionalNewValue = currentDragStartValue - (angleDelta * valuePerRadian)
                        let bounds = effectiveStepBounds
                        var snappedValue = (provisionalNewValue / self.stepValue).rounded() * self.stepValue
                        snappedValue = max(bounds.min, min(bounds.max, snappedValue))
                        self.value = snappedValue

                    }
                    .onEnded { _ in
                        dragStartValue = nil
                        dragStartTouchAngle = nil
                    }
            )
            .onAppear {
                // 初期値を範囲内にクランプ
                self.value = max(minValue, min(maxValue, self.value))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.001))
        }
    }

    // 現在の値に基づいてTicksViewの回転角度を計算
    private func calculateRotationForValue(_ currentValue: Double) -> Angle {
        // normalizedValue: 0 (minValue時) から 1 (maxValue時)
        let normalizedValue = (currentValue - minValue) / valueRange
        // TicksViewスケール上でのcurrentValueの角度 (0.5が中央=0度)
        let angleOfValueOnScale = (normalizedValue - 0.5) * displayArcAngle.radians
        // この角度がトップに来るように、逆方向に回転
        return Angle(radians: -angleOfValueOnScale)
    }
}

struct TicksView: View {
    let minValue: Double
    let maxValue: Double
    let tickCount: Int
    let minorTicksPerMajor: Int
    let radius: CGFloat
    let arcCenter: CGPoint
    let displayArcAngle: Angle

    private var totalMajorSegments: Int { max(1, tickCount - 1) }

    var body: some View {
        ZStack {
            ForEach(0..<tickCount, id: \.self) { majorTickIndex in
                let majorTickProportion = Double(majorTickIndex) / Double(totalMajorSegments)
                let majorAngle = Angle(radians: (majorTickProportion - 0.5) * displayArcAngle.radians)

                TickShape(isMajor: true, angle: majorAngle, radius: radius, arcCenter: arcCenter)
                    .stroke(Color.black, lineWidth: 1.5)

                if majorTickIndex < totalMajorSegments {
                    let anglePerMajorSegment = displayArcAngle.radians / Double(totalMajorSegments)
                    
                    if minorTicksPerMajor > 0 {
                        ForEach(1...minorTicksPerMajor, id: \.self) { minorTickIndexInSegment in
                            let minorTickProportionInSegment = Double(minorTickIndexInSegment) / Double(minorTicksPerMajor + 1)
                            let minorAngleOffset = minorTickProportionInSegment * anglePerMajorSegment
                            let minorAngle = Angle(radians: majorAngle.radians + minorAngleOffset)
                            
                            TickShape(isMajor: false, angle: minorAngle, radius: radius, arcCenter: arcCenter)
                                .stroke(Color.black, lineWidth: 1)
                        }
                    }
                }
            }
        }
    }
}

struct TickShape: Shape {
    let isMajor: Bool
    let angle: Angle
    let radius: CGFloat
    let arcCenter: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let tickLength = isMajor ? 12.0 : 6.0
        let tickStartRadius = radius
        let tickEndRadius = radius - tickLength

        let x1 = arcCenter.x + tickStartRadius * sin(CGFloat(angle.radians))
        let y1 = arcCenter.y - tickStartRadius * cos(CGFloat(angle.radians))

        let x2 = arcCenter.x + tickEndRadius * sin(CGFloat(angle.radians))
        let y2 = arcCenter.y - tickEndRadius * cos(CGFloat(angle.radians))

        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        return path
    }
}

// --- プレビュー用のコード ---
struct CircularPicker_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var currentValue: Double // @Stateプロパティの宣言

        // 明示的な初期化メソッドを追加
        init() {
            // @Stateプロパティを初期化
            _currentValue = State(initialValue: 5000)
        }
        
        var body: some View {
            ZStack {
                VStack {
                    CircularPicker(value: $currentValue,
                                   minValue: 0.0,
                                   maxValue: 10000.0,
                                   tickCount: 11,     // 0, 1.4, ..., 14.0 の場合11個の主目盛り
                                   minorTicksPerMajor: 3) // 画像に合わせて3本
                        .frame(width: 300, height: 200) // ピッカーのサイズ
                    
                    Text("Selected Value: \(currentValue, specifier: "%.1f")")
                        .padding()
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    static var previews: some View {
        PreviewWrapper() // ここがエラー箇所 (line 139)
    }
}
