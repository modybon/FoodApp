//
//  FilterHelper.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-27.
//

import Foundation

class FilterHelper: ObservableObject {
    @Published var maxDeliveryFee : Float = 2.99
    @Published var dietOptions : String = "Food"
}
