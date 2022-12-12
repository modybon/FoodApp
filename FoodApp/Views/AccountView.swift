//
//  AccountView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @EnvironmentObject var loginModel: AppViewModel
    let auth = Auth.auth()
    
    var body: some View {
        NavigationView{
             List{
            VStack{
                HStack{
                    Text("Welcome : ").font(.headline)
                    Spacer()
                    Text((self.fireDBHelper.user.userName) ?? "ASB")
                }
                HStack{
                    Text("Email: ")
                    Spacer()
                    Text((self.fireDBHelper.user.email) ?? "NA")
                }
                HStack{
                    Text("No. of Saved Addresses: ")
                    Spacer()
                    Text((String(self.fireDBHelper.user.savedAddresses?[0] ?? "0" )))
                }
            }
                Button(action:{
                    loginModel.signedIn = false
                    
                    do{
                        try self.loginModel.auth.signOut()
                    }catch{
                        print(#function, "Not able to sign out!")
                    }
                        
                    return
                }){
                    Text("Logout")
                }
            }
           
        }.onAppear(){
            DispatchQueue.main.async {
                self.fireDBHelper.getUserDetails(userID: auth.currentUser?.uid)
            }
            
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
