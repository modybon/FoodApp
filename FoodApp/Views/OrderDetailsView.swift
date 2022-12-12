//
//  OrderDetailsView.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-12-05.
//

import SwiftUI

struct OrderDetailsView: View {
    var orderTemp : Order
    
    var body: some View {
        VStack{
            
            Text("Order Details")
                .font(.title)
                .padding(50)
            
            Text("Title : \(orderTemp.restaurant.name)")
                .fontWeight(.bold)
            
            Spacer()
        }//VStack ends
        .frame(maxWidth : .infinity)
    }
}
