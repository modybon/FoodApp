//
//  Order.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-11-14.
//

import Foundation
class Order{
    var restaurant: String
    var amountPayed: Double
    
    init(res: String, amount: Double){
        self.restaurant = res
        self.amountPayed = amount
    }
}
