//
//  Order.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-11-14.
//

import Foundation
class Order : Identifiable{
    var id = UUID()
    var totalPrice: Float
    var qty : Int
    var item : MenuItem
    
    init(totalPrice: Float, qty : Int,item : MenuItem){
        self.totalPrice = totalPrice
        self.qty = qty
        self.item = item
    }
}
