//
//  AccountView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    
    @EnvironmentObject var user: User
    @EnvironmentObject var loginModel: AppViewModel
    
    let auth = Auth.auth()
    
    var body: some View {
        NavigationView{
//            Section{
//                Text("My Account").fontWeight(.bold)
//            }
            List{
            VStack{
                HStack{
                    Text("Name: ")
                    Spacer()
                   // Text(user.userName)
                }
                HStack{
                    Text("Email: ")
                    Spacer()
                  //  Text(user.email)
                }
                HStack{
                    Text("Saved Addresses: ")
                    Spacer()
                    //Text(User.username)
                }
            }
                Button(action:{
                    loginModel.signedIn = false
                    return
                }){
                    Text("Logout")
                }
            }
           
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
