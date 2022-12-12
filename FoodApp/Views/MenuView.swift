//
//  MenuView.swift
//  FoodApp
//
//  Created by Timothy Dow on 2022-12-11.
//

import SwiftUI

struct MenuView: View {
    var menu : [MenuItem] = [
        MenuItem(name: "Burger", price: 9.99, image:"person.fill"),
        MenuItem(name: "Fries", price: 3.99, image:"person.fill"),
        MenuItem(name: "Cola", price: 1.99, image:"person.fill"),
        MenuItem(name: "Cookie", price: 0.99, image:"person.fill"),
        MenuItem(name: "Club Sandwich", price: 0.99, image:"person.fill"),
        MenuItem(name: "Flafel Wrap", price: 0.99, image:"person.fill"),
        MenuItem(name: "Shawarema", price: 0.99, image:"person.fill"),
        MenuItem(name: "Fried Chicken Sandwich", price: 0.99, image:"person.fill"),
        MenuItem(name: "Poutine", price: 0.99, image:"person.fill"),
    ]
    @State private var isShowingItemDetails = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var locationHelper : LocationHelper
    var isShowingView : Binding<Bool>
    var restaurant : Restaurant
    var orderHelper : OrderHelper = OrderHelper()
    @State var selectedItem : MenuItem?
    var isDelivery : Bool
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment:.leading){
                    Image(systemName: "person.fill").font(.title).frame(width: UIScreen.main.bounds.width,height: 80).padding(.top,10)
                    Image(systemName: "xmark").font(.title).padding([.bottom,.top]).onTapGesture {
                        self.isShowingView.wrappedValue = false
                        dismiss()
                    }.padding(.leading)
                }
                Text(self.restaurant.name).font(.title).fontWeight(.bold)
                Text("\(String(format:"%.f",((restaurant.approxDeliveryTime)))) - \((String(format:"%.f",restaurant.approxDeliveryTime + 5))) mins \(String(format:"%.2f",restaurant.deliveryFee)) Delivery Fee").font(.caption).fontWeight(.medium)
                List{
                    ForEach(self.menu){menuItem in
                        HStack{
                            Image(systemName: menuItem.image).font(.system(size: 60))
                            VStack(alignment:.leading){
                                Text(menuItem.name).font(.title3).fontWeight(.bold)
                                Text("$\(String(format: "%.2f", menuItem.price))").font(.caption).fontWeight(.bold)
                            }
                        }.onTapGesture {
                            self.isShowingItemDetails = true
                            selectedItem = menuItem
                        }
                    }
                }.listStyle(.plain)
                Spacer()
                if(!self.orderHelper.orderList.isEmpty){
                    if(self.isDelivery){
                        NavigationLink(destination: DeliveryOrderView(currentUserPosition: self.$locationHelper.currentLocation, restaurantPosition: restaurant.location!, restaurant: self.restaurant, orders: self.orderHelper.orderList)){
                            Rectangle().foregroundColor(.black).overlay(
                                Button(action:{
                                    
                                }){
                                    Text("Order \(self.orderHelper.orderList.count) Items").foregroundColor(.white).font(.title3)
                                }.frame(maxWidth:.infinity)
                            )
                            .padding([.leading,.trailing])
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60)
                        }
                    }else{
                        NavigationLink(destination: PickUpOrderView(currentUserPosition: self.$locationHelper.currentLocation, restaurantPosition: restaurant.location!)){
                            Rectangle().foregroundColor(.black).overlay(
                                Button(action:{
                                    
                                }){
                                    Text("Order \(self.orderHelper.orderList.count) Items").foregroundColor(.white).font(.title3)
                                }.frame(maxWidth:.infinity)
                            )
                            .padding([.leading,.trailing])
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60)
                        }
                    }
                    
                }
            }.sheet(isPresented: $isShowingItemDetails){
                if(self.selectedItem != nil){
                    MenuItemDetails(isShowingView: self.$isShowingItemDetails, item: selectedItem!).environmentObject(self.orderHelper)
                }
            }
        }.onAppear(){
            //self.locationHelper.currentLocation
        }
    }
}
