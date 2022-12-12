//
//  OrdersView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct OrdersView: View {
    var arr = [1,2,3,4,5]
    var body: some View {
        NavigationView{
            List{
                Text("Orders").font(.system(size: 40)).fontWeight(.bold).listRowSeparator(.hidden)
                ForEach(arr,id: \.self){ item in
                    NavigationLink(destination: OrderDetailsView()){
                        OrderDetailsView()
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

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
