//
//  SearchBar.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI

struct SearchBar: View {
    var searchText : Binding<String>
    var filterAvailble : Bool
    var title: String
    var color : Color
    @State private var isshowingFilterView = false
    @State var selected : Int?
    @EnvironmentObject var locationHelper : LocationHelper
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
                    
                    TextField(self.title, text: searchText)
                    if(self.filterAvailble){
                        HStack{
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(maxWidth:1,maxHeight: 42)
                            Button(action:{
                                self.selected = 1
                                isshowingFilterView.toggle()
                            }){
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundColor(.black)
                                    .font(.system( size: 30, weight: .bold, design: .default))
                                    .padding(.trailing)
                            }.sheet(isPresented: $isshowingFilterView){
                                FilterView().environmentObject(self.locationHelper)
                            }
                        }
                    }
                }.padding([.leading,.trailing])
            )
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchText : String = ""
    static var previews: some View {
        SearchBar(searchText: $searchText,filterAvailble: true,title: "Food,Drinks",color: .gray.opacity(0.3))
    }
}
