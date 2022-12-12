//
//  DietryOptions.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-27.
//

import Foundation

enum DietryOptions: String ,Identifiable{
    var id: Self { self }
    case vegetarian = "Vegeterian" , vegan = "Vegan", halal = "Halal", allergyFree = "Allergy Free", glutenFree = "Gluten Free"
}
