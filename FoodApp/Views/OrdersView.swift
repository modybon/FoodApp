//
//  OrdersView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var orderHelper : OrderHelper
    var body: some View {
        NavigationView{
            List{
                Text("Orders").font(.system(size: 40)).fontWeight(.bold).listRowSeparator(.hidden)
                ForEach(orderHelper.orderList){ order in
                    NavigationLink(destination: OrderDetailsView(orderTemp: order)){
                        CustomListTile(orderTemp: order)
                            .onTapGesture {
                                print(#function, "\(order) selected")
                            }//TapGesture ends
                            
                        //CustomeListTile ends
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

struct CustomListTile : View{
    
    var orderTemp : Order
    
    var body: some View{
        VStack(alignment: .leading){
            Text("\(orderTemp.restaurant.name)")
                .fontWeight(.bold)
            
            Text("\(orderTemp.amountPayed)")
        }
    }
}

