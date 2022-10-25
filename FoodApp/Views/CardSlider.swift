//
//  CardSlider.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI

struct CardSlider: View {
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat = UIScreen.main.bounds.height - 100
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5.0)
                    .foregroundColor(.black)
                    .padding(10)
            }
            .frame(minWidth: UIScreen.main.bounds.width)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .background(Color.white)
            .cornerRadius(15)
            ResturantView()
        }
        .offset(y: max(0, position + self.dragTracker.height))
        .gesture(DragGesture().updating($dragTracker){drag , state, transaction  in
            state = drag.translation
        }.onChanged{ _ in
            dragging = true
        }.onEnded(onDragEnded(drag:))
        )
    }
    private func onDragEnded(drag: DragGesture.Value){
        dragging = false
        let high = UIScreen.main.bounds.height - 100
        let low: CGFloat = 100
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        
        if (dragDirection > 0){
            position = high
        }else{
            position = low
        }
        
    }
}

struct CardSlider_Previews: PreviewProvider {
    static var previews: some View {
        CardSlider()
    }
}
