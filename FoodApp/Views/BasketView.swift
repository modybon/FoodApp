//
//  BasketView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI


struct BasketView: View {
    let grayColor : Color = Color(red: 0.917, green: 0.908, blue: 0.911, opacity: 1)
    let arr = [1,2,3,4,5]
    var body: some View {
        NavigationView{
            List{
                Text("Carts").font(.system(size: 40)).fontWeight(.bold).listRowSeparator(.hidden)
                ForEach(arr,id: \.self){ item in
                    NavigationLink(destination: CartOrderView()){
                        CartOrderView()
                            .onTapGesture {
                                print("Item Tapped")
                            }
                    }
                }.onDelete{_ in
                    print("Item Deleted")
                }
            }
            .listStyle(.plain)
        }
        
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}




