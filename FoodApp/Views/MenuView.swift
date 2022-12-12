//
//  MenuView.swift
//  FoodApp
//
//  Created by Timothy Dow on 2022-12-11.
//

import SwiftUI

struct MenuView: View {
    let resturant : Restaurant
    @EnvironmentObject var orderHelper : OrderHelper
    @State var foodA : Bool
    @State var foodB : Bool
    @State var foodC : Bool
    @State var orderDetails : String
    
    var body: some View {
        
        NavigationView{
            VStack{
                Toggle("Food A", isOn: $foodA)
                Toggle("Food B", isOn: $foodB)
                Toggle("Food C", isOn: $foodC)
                TextField("orderDetails", text: $orderDetails)
                    .padding()
                Button("Order"){
                    createOrder()
                }
            }
            .navigationTitle("Menu")
        }
    }
    
    func createOrder() {
        let choices : [Bool] = [self.foodA, self.foodB, self.foodC]
        let cost1 = self.foodA ? 2.99 : 0.0
        let cost2 = self.foodB ? 3.99 : 0.0
        let cost3 = self.foodC ? 4.99 : 0.0
        let finalCost = cost1+cost2+cost3
        
        let order = Order(res: resturant, amount: finalCost, choices: choices, orderDetails: self.orderDetails)
        orderHelper.addOrder(order: order)
    }
}
