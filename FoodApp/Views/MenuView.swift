//
//  MenuView.swift
//  FoodApp
//
//  Created by Timothy Dow on 2022-12-11.
//

import SwiftUI

struct MenuView: View {
    var menu : [MenuItem] = [
        MenuItem(name: "Burger", price: 9.99, image:"person.fill"),
        MenuItem(name: "Fries", price: 3.99, image:"person.fill"),
        MenuItem(name: "Cola", price: 1.99, image:"person.fill"),
        MenuItem(name: "Cookie", price: 0.99, image:"person.fill"),
        MenuItem(name: "Club Sandwich", price: 0.99, image:"person.fill"),
        MenuItem(name: "Flafel Wrap", price: 0.99, image:"person.fill"),
        MenuItem(name: "Shawarema", price: 0.99, image:"person.fill"),
        MenuItem(name: "Fried Chicken Sandwich", price: 0.99, image:"person.fill"),
        MenuItem(name: "Poutine", price: 0.99, image:"person.fill"),
    ]
    @State private var isShowingItemDetails = false
    var body: some View {
        NavigationView{
            var selectedItem : MenuItem = menu[0]
            VStack{
                Image(systemName: "person.fill").font(.title).frame(width: UIScreen.main.bounds.width,height: 80).padding(.top,10)
                Text("Resturant Name").font(.title).fontWeight(.bold)
                Text("40-60 min $0.99 Delivery Fee").font(.caption).fontWeight(.medium)
                List{
                    ForEach(self.menu){menuItem in
                        HStack{
                            Image(systemName: menuItem.image).font(.system(size: 60))
                            VStack(alignment:.leading){
                                Text(menuItem.name).font(.title3).fontWeight(.bold)
                                Text("$\(String(format: "%.2f", menuItem.price))").font(.caption).fontWeight(.bold)
                            }.onTapGesture {
                                self.isShowingItemDetails = true
                                selectedItem = menuItem
                            }
                        }
                    }
                }.listStyle(.plain)
                Spacer()
                Rectangle().foregroundColor(.black).overlay(
                    Button(action:{}){
                        Text("View Cart (1)").foregroundColor(.white).font(.title3)
                    }.frame(maxWidth:.infinity)
                )
                .padding([.leading,.trailing])
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60)
            }.sheet(isPresented: $isShowingItemDetails){
                MenuItemDetails(isShowingView: self.$isShowingItemDetails, item: selectedItem)
            }
        }
    }
}
