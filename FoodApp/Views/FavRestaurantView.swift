//
//  FavRestaurantView.swift
//  FoodApp
//
//  Created by Arpit Bhullar on 2022-12-12.
//

import SwiftUI
import FirebaseAuth

struct FavRestaurantView: View {
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @EnvironmentObject var loginModel: AppViewModel
    let auth = Auth.auth()
    
    var body: some View {
        NavigationView{
            List(self.fireDBHelper.favRestaurantList){res in
                VStack(){
                    Text(res.name)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title)
                    Text("Phone: "+res.phoneNumber)
                        .multilineTextAlignment(.center)
                    Text("Delivery Fee: "+String(res.deliveryFee))
                        .multilineTextAlignment(.center)
                    Text("Walk Time: "+String(res.approxWalkTime))
                        .multilineTextAlignment(.center)
                    Text("Delivery Time: "+String(res.approxDeliveryTime))
                        .multilineTextAlignment(.center)
                }
            }
            .onAppear(){
                    DispatchQueue.main.async {
                        self.fireDBHelper.getfavRestuarants(userID: auth.currentUser?.uid)
                    }
            }
        }
    }
}

struct FavRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        FavRestaurantView()
    }
}
