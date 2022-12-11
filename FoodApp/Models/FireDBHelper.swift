//
//  FireDBHelper.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-12-04.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    private let store : Firestore
    @Published var user = User()
    private let COLLECTION_NAME : String = "Users"
    
    
    
    //singleton design pattern
    private static var shared : FireDBHelper?
    
    init(database : Firestore){
        self.store = database
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return shared!
    }
    
    
    func insertUser(newUser : User){
        
        do{
            try self.store.collection(COLLECTION_NAME).document(newUser.id!).setData(from: newUser)
            
        }catch let error as NSError{
            print(#function, "Error while inserting document on firestore \(error)")
        }
    }
    
    func getUserDetails(userID: String?){
        print(#function, "user id got is ****: \(userID)")
        self.store.collection("Users").whereField("id", isEqualTo: String(userID!))
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("You are here: \(document.documentID) => \(document.data())")
                        let data = document.data()
                        let name = data["userName"] as? String ?? ""
                        let phone = data["phone"] as? String ?? ""
                        let email = data["email"] as? String ?? ""
                        let savedAddresses = data["savedAddresses"] as? [String] ?? [""]
                     //   let favRestaurants = data["favRestaurants"] as? [String] ?? [""]
                        self.user = User(id: userID!, uName: name, email: email, phone: phone, savedAddresses: savedAddresses)
                     }
                }
        }
//            docRef.getDocument { (document, error) in
//                self.user = document.flatMap({
//                                $0.data().flatMap({ (data) in
//                                    return User(dictionary: data)
//                                })
//                            })!
//                print("City: \(self.user)")
//
//                        }
    }
    
    func updateUser(userToUpdate: User){
        self.store
            .collection(COLLECTION_NAME)
            .document(userToUpdate.id!)
            .updateData(["Name": userToUpdate.userName,
                        "Phone": userToUpdate.phone,
                         "Email": userToUpdate.email]){error in
                if let err = error{
                    print(#function, "Error while updating document \(err)")
                }else{
                    print(#function, "User \(userToUpdate.userName) updated successfully")
                }
            }
    }
    
    
    func updateUserRes(addRes: Resturant, addorDel: Bool){
        if(addorDel){
        do{
            try self.store.collection(COLLECTION_NAME).document(self.user.id!).collection("favRestaurants").document(addRes.name).setData(from: addRes, merge: true)
            
        }catch let error as NSError{
            print(#function, "Error while inserting document on firestore \(error)")
        }
        }else{
            self.store
                .collection(COLLECTION_NAME)
                .document(self.user.id!).collection("favRestaurants").document(addRes.name)
                .delete(){error in
                    if let err = error{
                        print(#function, "Error while updating document \(err)")
                    }else{
                        print(#function, "User \(self.user.userName) updated successfully")
                    }
                }
        }
    }
    func deleteUser(userToDelete: User){
        self.store
            .collection(COLLECTION_NAME)
            .document(userToDelete.id!)
            .delete(){error in
                if let err = error{
                    print(#function, "Error while updating document \(err)")
                }else{
                    print(#function, "User \(userToDelete.userName) updated successfully")
                }
            }
    }
}

