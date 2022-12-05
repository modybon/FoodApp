//
//  User.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-11-14.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable,Hashable{
    var id: String?
    var userName: String?
    var email: String?
    var phone: String?
    var favRestaurants: [String]?
    var savedAddresses: [String]?
    
    init(){
        
    }
    init(id: String,uName: String, email: String, phone: String, favRes: [String], savedAddresses: [String]){
        self.id = id
        self.userName = uName
        self.email = email
        self.phone = phone
        self.favRestaurants = favRes
        self.savedAddresses = savedAddresses
    }
    
    //Failable initializer
     init?(dictionary: [String: Any]){
        
         guard let id = dictionary["id"] as? String else{
             return nil
         }
         
        guard let username = dictionary["userName"] as? String else{
            return nil
        }
        
        guard let email = dictionary["email"] as? String else{
            return nil
        }
        
        guard let phone = dictionary["phone"] as? String else{
            return nil
        }
        
        guard let favRest = dictionary["favRestaurants"] as? [String] else{
            return nil
        }
        
        guard let savedAdd = dictionary["savedAddresses"] as? [String] else{
            return nil
        }
        
         self.init(id: id,uName: username, email: email, phone: phone, favRes: favRest, savedAddresses: savedAdd)
        
    }
    
}
