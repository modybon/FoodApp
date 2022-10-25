//
//  DeliveryView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI

struct DeliveryView: View {
    @State var searchResturant : String = ""
    @State var orderMethod : OrderMethod
    @State var deleveryBtnIsDisabled : Bool
    @State var pickupBtnIsDisabled : Bool
    var body: some View {
        VStack{
            SearchBar(color: .gray.opacity(0.3))
            List{
                ResturantView()
                ResturantView()
                ResturantView()
                ResturantView()
                ResturantView()
                ResturantView()
                ResturantView()
            }.listStyle(.grouped)
            .refreshable {
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) { // Change `2.0` to the desired number of seconds.
                   // Code you want to be delayed
                    print("Refreshed")
                }
            }
            Spacer()
           
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
         // End of Vstack
    }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView(orderMethod: .Delivery, deleveryBtnIsDisabled: false, pickupBtnIsDisabled: true)
    }
}
