//
//  AccountView.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-10-10.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @EnvironmentObject var loginModel: AppViewModel
    @EnvironmentObject var locationHelper: LocationHelper
    @State var selection: Int? = 0
    let auth = Auth.auth()
    
    var body: some View {
        NavigationView{
            
            
            VStack{
                NavigationLink(destination: FavRestaurantView(), tag : 1, selection: self.$selection ){}
                Section{
                    HStack{
                        Text("Welcome ").font(.headline)
                        Text((self.fireDBHelper.user.userName) ?? "NA").font(.headline).fontWeight(.bold)
                    }
                }
                Spacer()
                Section("Email"){
                    HStack{
                        Text((self.fireDBHelper.user.email) ?? "NA")
                    }
                }
                Spacer()
                Section("Contact Number"){
                    HStack{
                        
                        Text((self.fireDBHelper.user.phone) ?? "NA")
                    }
                }
                Spacer()
                Section("Restaurants"){
                    HStack{
                        Text("Click to open saved Favorite Restaurants List ").foregroundColor(.red)
                        
                        //     Text((String(self.fireDBHelper.user.favRestaurants?[0] ?? "0" )))
                    }
                    .onTapGesture {
                        self.selection = 1
                        self.fireDBHelper.getfavRestuarants(userID: self.auth.currentUser?.uid)
                    }
                }
                Spacer()
                Section("Saved Addresses"){
                    HStack{
                        Text("No. of Saved Addresses: ")
                        Text((String(self.fireDBHelper.user.savedAddresses?[0] ?? "0" )))
                    }
                }
            }
            
            
            
            .onAppear(){
                DispatchQueue.main.async {
                    self.fireDBHelper.getUserDetails(userID: auth.currentUser?.uid)
                    //  self.locationHelper.currentLocation?.description
                }
                
            }
            .navigationBarTitle("Account Details")
            .navigationBarItems(trailing:
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
            })
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
