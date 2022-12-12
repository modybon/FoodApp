//
//  Resturant.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-20.
//

import Foundation

class Resturant : Identifiable, Codable{
    var name : String = "NA"
    var phoneNumber : String = "NA"
    var distanceFromCL : Float = 0
    var deliveryFee : Float = 0
    var approxWalkTime : Float = 0
    var approxDeliveryTime : Float = 0
    
    enum CodingKeys: String, CodingKey{
        case name
        case phoneNumber
        case distanceFromCL
        case deliveryFee
        case approxWalkTime
        case approxDeliveryTime
    }
}
