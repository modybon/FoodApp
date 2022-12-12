//
//  MenuItem.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-12-11.
//

import Foundation
import UIKit

struct MenuItem : Identifiable{
    var id : UUID = UUID()
    var name : String
    var price : Float
    var image : String = "person.fill"
}
