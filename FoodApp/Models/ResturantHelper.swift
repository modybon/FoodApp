//
//  ResturantHelper.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-20.
//

import Foundation
import MapKit
class ResturantHelper : ObservableObject{
    @Published var currentResturantAnnotation : MKAnnotation?
    @Published var currentResturantMapItem : MKMapItem?
    @Published var resturantsList : [Restaurant] = [Restaurant]()
}
