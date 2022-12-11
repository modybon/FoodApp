//
//  Order.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-11-14.
//

import Foundation
class Order{
    var restaurant: Resturant
    var amountPayed: Double
    var choices : [Bool]
    var orderDetails : String
    
    init(res: Resturant, amount: Double, choices: [Bool], orderDetails: String){
        self.restaurant = res
        self.amountPayed = amount
        self.choices = choices
        self.orderDetails = orderDetails
    }
}
