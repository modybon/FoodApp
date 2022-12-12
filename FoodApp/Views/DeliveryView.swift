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
    //@EnvironmentObject var filterHelper : FilterHelper
    var body: some View {
        VStack{
            SearchBar(searchText:$searchText,filterAvailble: true, title: "Food, Deliver,etc.",color: .gray.opacity(0.3)).environmentObject(self.locationHelper)
            if(!self.$locationHelper.resturantsList.isEmpty){
                ZStack{
                    List{
                        ForEach(self.$locationHelper.resturantsList){ resturant in
                            RestaurantView(resturant: resturant.wrappedValue,isDelivery: true)
                        }
                    }.listStyle(.grouped)
                    .refreshable {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) { // Change `2.0` to the desired number of seconds.
                           // Code you want to be delayed
                            print("Refreshed")
                        }
                    }
                    if(!self.searchText.isEmpty){
                        if(self.locationHelper.resturantsList.contains(where: {$0.name.contains(searchText)})){
                            List{
                                ForEach(self.searchResults){ resturant in
                                    HStack{
                                        Image(systemName: "person.fill")
                                        VStack(alignment:.leading){
                                            Text("\(resturant.name)")
                                            HStack{
                                                Text("$\(String(format:"%.2f",resturant.deliveryFee)) Delivery Fee")
                                                Text("\(String(format:"%.f",((resturant.approxDeliveryTime)))) - \((String(format:"%.f",resturant.approxDeliveryTime + 5))) mins")
                                            }
                                        }.frame(maxWidth:.infinity)
                                    }
                                }
                            }.listStyle(.grouped)
                        }
                    }
                }// End of Zstack
                
            }else{
                Text("NO RESTURANTS NEAR BY 😢")
            }
            Spacer()
           
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
         // End of Vstack
    }
    var searchResults: [Restaurant] {
            if searchText.isEmpty {
                return [Restaurant]()
            } else {
                return self.locationHelper.resturantsList.filter { $0.name.contains(self.searchText)}
            }
        }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView(orderMethod: .Delivery, deleveryBtnIsDisabled: false, pickupBtnIsDisabled: true)
    }
}



