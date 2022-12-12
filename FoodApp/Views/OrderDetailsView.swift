//
//  OrderDetailsView.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-12-05.
//

import SwiftUI

struct OrderDetailsView: View {
    @EnvironmentObject var orderHelper: OrderHelper
    var body: some View {
        NavigationView{
//            List(self.orderHelper.orderList){order in
//                VStack(){
//                    Text(order.item.name)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .font(.title)
//                    Text("Quantity: "+order.qty)
//                        .multilineTextAlignment(.center)
//                    Text("Price: "+String(order.price))
//                        .multilineTextAlignment(.center)
//                }
//            }
        }
    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView()
    }
}
