//
//  AccountView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView{
            Section{
                Text("My Account")
            }
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
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
