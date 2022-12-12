//
//  RestaurantHelper.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-20.
//

import Foundation
import MapKit
class RestaurantHelper : ObservableObject{
    @Published var currentRestaurantAnnotation : MKAnnotation?
    @Published var currentRestaurantMapItem : MKMapItem?
    @Published var restaurantsList : [Restaurant] = [Restaurant]()
}
