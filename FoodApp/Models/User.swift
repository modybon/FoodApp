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
    
    init(uName: String, pass: String, email: String, phone: Int, favRes: [String], savedAddresses: [String]){
        self.id = UUID()
        self.userName = uName
        self.email = email
        self.password = pass
        self.phone = phone
        self.favRestaurants = favRes
        self.savedAddresses = savedAddresses
    }
    
}
