//
//  Restaurant.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-20.
//

import Foundation
import MapKit
class Restaurant : Identifiable, Codable{
    var name : String = "NA"
    var phoneNumber : String = "NA"
    var distanceFromCL : Float = 0
    var deliveryFee : Float = 0
    var approxWalkTime : Float = 0
    var approxDeliveryTime : Float = 0
    var isFavorite: Bool = false
    var location : CLLocation?
    
    init(){
        
    }
    init(name: String, phone: String, distancefromCL: Float, deliveryFee: Float, appxWalkTime: Float, appxDelTime: Float, loc: CLLocation){
        self.name = name
        self.phoneNumber = phone
        self.distanceFromCL = distancefromCL
        self.deliveryFee = deliveryFee
        self.approxWalkTime = appxWalkTime
        self.approxDeliveryTime = appxDelTime
        self.location = loc
    }
    
    enum CodingKeys: String, CodingKey{
        case name
        case phoneNumber
        case distanceFromCL
        case deliveryFee
        case approxWalkTime
        case approxDeliveryTime
        case isFavorite
    }
    
}
