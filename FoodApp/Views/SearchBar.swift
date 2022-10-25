//
//  SearchBar.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI

struct SearchBar: View {
    let names = ["Pizza", "Mcdonalds", "KFC", "Popeyes"]
    @State var searchText : String = ""
    var color : Color
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(25)
            .padding()
            .frame(maxWidth:.infinity,maxHeight: 80)
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                    
                    TextField("Food,Drink,etc.", text: $searchText)
                    HStack{
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(maxWidth:1,maxHeight: 42)
                        Image(systemName: "slider.horizontal.3")
                            .font(.system( size: 30, weight: .bold, design: .default))
                            .padding(.trailing)
                    }
                    
                }.padding([.leading,.trailing])
            )
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(color: .gray.opacity(0.3))
    }
}
