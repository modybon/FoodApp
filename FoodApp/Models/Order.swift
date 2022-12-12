//
//  Order.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-11-14.
//

import Foundation
<<<<<<< Updated upstream
class Order{
    var restaurant: Restaurant
=======
class Order: Identifiable{
    
    var restaurant: Resturant
>>>>>>> Stashed changes
    var amountPayed: Double
    var choices : [Bool]
    var orderDetails : String
    
    init(res: Restaurant, amount: Double, choices: [Bool], orderDetails: String){
        self.restaurant = res
        self.amountPayed = amount
        self.choices = choices
        self.orderDetails = orderDetails
    }
}
