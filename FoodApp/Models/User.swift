//
//  User.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-11-14.
//

import Foundation
class User: Identifiable, ObservableObject{
    var id: UUID
    var userName: String
    var password: String
    var email: String
    var phone: Int
    var favRestaurants: [String]
    var savedAddresses: [String]
    
    init(){
        self.id = UUID()
        self.userName = "userName"
        self.email = "email"
        self.password = "password"
        self.phone = 123
        self.favRestaurants = ["favRestaurants"]
        self.savedAddresses = ["savedAddresses"]
    }
    
}
