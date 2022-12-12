//
//  RestaurantPin.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-04.
//

import Foundation
import CoreLocation
import MapKit
class RestaurantPin : NSObject,Identifiable, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
    var rating : Float
    //var image : String
    var name : String
    
    init(name: String, location : CLLocationCoordinate2D, rating: Float) {
        self.name = name
        self.rating = rating
        self.coordinate = location
    }
}
