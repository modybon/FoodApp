//
//  SlideOverView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-25.
//

import SwiftUI

struct SlideOverView<Content> : View where Content : View {

    var content: () -> Content
    var isFullyExtended : Binding<Bool>
    
//    public init(content: @escaping () -> Content) {
//        self.content = content
//    }
    
    public init(isFullyExtended: Binding<Bool>, content: @escaping () -> Content ){
        self.content = content
        self.isFullyExtended = isFullyExtended
    }
     
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: CardSlider(isFullyExtended: self.isFullyExtended))
    }
}

//struct SlideOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideOverView()
//    }
//}
