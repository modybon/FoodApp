//
//  SlideOverView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-25.
//

import SwiftUI

struct SlideOverView<Content> : View where Content : View {

    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
     
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: CardSlider())
    }
}

//struct SlideOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideOverView()
//    }
//}
