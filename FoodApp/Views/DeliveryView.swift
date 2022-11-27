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
    @State var searchText : String = ""
    @EnvironmentObject var locationHelper : LocationHelper
    var body: some View {
        VStack{
            SearchBar(searchText:$searchText,filterAvailble: true, title: "Food, Deliver,etc.",color: .gray.opacity(0.3))
            if(!self.$locationHelper.resturantsList.isEmpty){
                List{
                    ForEach(self.$locationHelper.resturantsList){ resturant in
                        ResturantView(resturantName: resturant.wrappedValue.name)
                    }
                }.listStyle(.grouped)
                .refreshable {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) { // Change `2.0` to the desired number of seconds.
                       // Code you want to be delayed
                        print("Refreshed")
                    }
                }
            }else{
                Text("NO RESTURANTS NEAR BY 😢")
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



