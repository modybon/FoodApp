//
//  DeliveryView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI

struct DeliveryView: View {
    @State var searchRestaurant : String = ""
    @State var orderMethod : OrderMethod
    @State var deleveryBtnIsDisabled : Bool
    @State var pickupBtnIsDisabled : Bool
    @State var searchText : String = ""
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var isShowingRestaurantMenu = false
    //@EnvironmentObject var filterHelper : FilterHelper
    @State var selectedRestaurant : Restaurant = Restaurant()
    var body: some View {
        VStack{
            SearchBar(searchText:$searchText,filterAvailble: true, title: "Food, Deliver,etc.",color: .gray.opacity(0.3)).environmentObject(self.locationHelper)
            if(!self.$locationHelper.restaurantsList.isEmpty){
                ZStack{
                    List{
                        ForEach(self.$locationHelper.restaurantsList){ restaurant in
                            RestaurantView(restaurant: restaurant.wrappedValue,isDelivery: true).onTapGesture {
                                self.isShowingRestaurantMenu = true
                                self.selectedRestaurant = restaurant.wrappedValue
                            }
                        }
                    }.listStyle(.grouped)
                    .refreshable {
                        self.locationHelper.preformRestaurantsSearch()
                    }
                    if(!self.searchText.isEmpty){
                        if(self.locationHelper.restaurantsList.contains(where: {$0.name.contains(searchText)})){
                            List{
                                ForEach(self.searchResults){ restaurant in
                                    HStack{
                                        Image(systemName: "person.fill")
                                        VStack(alignment:.leading){
                                            Text("\(restaurant.name)")
                                            HStack{
                                                Text("$\(String(format:"%.2f",restaurant.deliveryFee)) Delivery Fee")
                                                Text("\(String(format:"%.f",((restaurant.approxDeliveryTime)))) - \((String(format:"%.f",restaurant.approxDeliveryTime + 5))) mins")
                                            }
                                        }.frame(maxWidth:.infinity)
                                    }.onTapGesture {
                                        self.isShowingRestaurantMenu = true
                                        selectedRestaurant = restaurant
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
           
        }
        .sheet(isPresented: $isShowingRestaurantMenu){
            MenuView(isShowingView: self.$isShowingRestaurantMenu, restaurant: selectedRestaurant,isDelivery: false)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
         // End of Vstack
    }
    var searchResults: [Restaurant] {
            if searchText.isEmpty {
                return [Restaurant]()
            } else {
                return self.locationHelper.restaurantsList.filter { $0.name.contains(self.searchText)}
            }
        }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView(orderMethod: .Delivery, deleveryBtnIsDisabled: false, pickupBtnIsDisabled: true)
    }
}



