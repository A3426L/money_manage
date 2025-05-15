//
//  CustomButton.swift
//  money_manage
//
//  Created by aru on 2025/05/15.
//

import SwiftUI

struct CustomButton: View {
    var label:String = "example"
    var action:() -> Void = {}
    @State var show:Bool = false
    @GestureState var isPressed = false
    var body: some View {
        Text(label)
            .padding()
            .accentColor(Color.white)
            .background(Color.blue)
            .cornerRadius(.infinity)
            .shadow(color: Color.black, radius: 0, x: 0, y: 6)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .updating($isPressed){_,_,_ in
                        show = true
                    }
                    .onEnded{ _ in
                        show = false
                        action()
                    }
            )
            .scaleEffect(show ? 0.8 : 1.0)
    }
}

#Preview {
    CustomButton()
}
