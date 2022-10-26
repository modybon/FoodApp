//
//  CardSlider.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI

struct CardSlider: ViewModifier {
    @State private var dragging = false
    // CGSize represents distance vector
    @GestureState private var dragTracker: CGSize = CGSize.zero
    // UIScreen.main.bounds.height represents height of the screen
    @State private var position : CGFloat = UIScreen.main.bounds.height - 380
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5.0)
                    .foregroundColor(Color.secondary)
                    .padding(10)
                
                content.padding(.top, 30)
                
            }
            .frame(minWidth: UIScreen.main.bounds.width)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .background(Color.white)
            .cornerRadius(15)
        }
        .offset(y:  max(0, position + self.dragTracker.height))
        .animation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0), value: dragging)
        .gesture(DragGesture()
            .updating($dragTracker) { drag, state, transaction in state = drag.translation }
            .onChanged {_ in  dragging = true }
            .onEnded(onDragEnded))
    }
    private func onDragEnded(drag: DragGesture.Value) {
        dragging = false
        let low = UIScreen.main.bounds.height - 320
        let high : CGFloat = 100
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        //can also calculate drag offset to make it more rigid to shrink and expand
        // if drag direction < 0 the direction is up if its positive its going down
        print(#function, "Drag Diection: \(dragDirection)")
        print(#function, "Predicted Drag End Location: \(drag.predictedEndLocation.y)")
        print(#function, "Drag Location Y: \(drag.location.y)")
        
        
        if dragDirection < 0 {
            print(#function, "High: : \(high)")
            position = high
            print(#function, "Dragged Up")
        } else {
            position = low
            print(#function, "Low: \(low)")
            print(#function, "Dragged Down")
        }
    }
}

//struct CardSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        CardSlider()
//    }
//}

//        .animation(dragging ? nil : {
//            Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)
//        }())
