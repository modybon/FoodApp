//
//  OrderHelper.swift
//  FoodApp
//
//  Created by Timothy Dow on 2022-12-11.
//

import Foundation
class OrderHelper : ObservableObject{
    @Published var orderList : [Order] = [Order]()
    
    func addOrder (order: Order) {
        orderList.append(order)
    }
}
