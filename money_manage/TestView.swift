//
//  TestView.swift
//  money_manage
//
//  Created by aru on 2025/05/12.
//
//
import SwiftUI

struct DraggableCircleView: View {
    @State private var offset: CGSize = .zero
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .offset(x: offset.width + dragOffset.width,
                    y: offset.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        let predicted = value.predictedEndTranslation

                        offset.width  = predicted.width + value.translation.width
                        offset.height = predicted.height + value.translation.height
                        dragOffset = .zero

                        
                    }
            )
            .animation(
                .interpolatingSpring(
                    stiffness: 200,
                    damping:   25,
                    initialVelocity: 0
            ),
                value: dragOffset)
    }
}

struct TestView: View {
    var body: some View {
        DraggableCircleView()
            .padding()
    }
}

#Preview {
    TestView()
}
