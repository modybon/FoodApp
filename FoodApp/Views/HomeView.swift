//
//  HomeView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI
import MapKit
struct HomeView: View {
    let orangeColor = Color(red: 0.968, green: 0.546, blue: 0.461)
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @EnvironmentObject var loginModel: AppViewModel
    @EnvironmentObject var locationHelper : LocationHelper
    @State var searchResturant : String = ""
    @State var orderMethod : OrderMethod = .Delivery
    @State var deleveryBtnIsDisabled : Bool = true
    @State var pickupBtnIsDisabled : Bool = false
    @State var selected : Int?
    @State private var isShowingCart = false
    @State var resturantHelper : ResturantHelper = ResturantHelper()
    var body: some View {
        VStack{
            HStack{
                Rectangle().foregroundColor((self.orderMethod == .Delivery) ? Color.black : Color.white)
                    .cornerRadius(25).frame(width: 95, height: 35)
                    .overlay(
                        Button(action: {
                            self.orderMethod = .Delivery
                            self.deleveryBtnIsDisabled.toggle()
                            self.pickupBtnIsDisabled.toggle()
                        }){
                            Text("Delivery").foregroundColor((self.orderMethod == .Pickup) ? Color.black : Color.white).frame(maxWidth:.infinity,maxHeight: .infinity)
                        }.disabled(self.deleveryBtnIsDisabled)
                    )// End of Rectangle
                
                Rectangle().foregroundColor((self.orderMethod == .Pickup) ? Color.black : Color.white)
                    .cornerRadius(25).frame(width: 95, height: 35)
                    .overlay(
                        Button(action: {
                            self.orderMethod = .Pickup
                            self.pickupBtnIsDisabled.toggle()
                            self.deleveryBtnIsDisabled.toggle()
                        }){
                            Text("Pickup").foregroundColor((self.orderMethod == .Delivery) ? Color.black : Color.white).frame(maxWidth:.infinity,maxHeight: .infinity)
                        }.disabled(self.pickupBtnIsDisabled)
                    )// End of Rectangle
            }// End of HStack
            Button(action: {
                self.selected = 1
            }){
                HStack{
                    Text("Now · Current Location").foregroundColor(.black)
                    Image(systemName: "arrowtriangle.down.fill").foregroundColor(.black)
                }
                .onTapGesture {
                    self.isShowingCart.toggle()
                }
                .sheet(isPresented: $isShowingCart){
                    LocationDetailsView()
                }
            }// End of Button
            if(orderMethod == .Delivery){
                DeliveryView(orderMethod: self.orderMethod, deleveryBtnIsDisabled: self.deleveryBtnIsDisabled, pickupBtnIsDisabled: self.pickupBtnIsDisabled).environmentObject(self.locationHelper)
            }else{
                PickUpView().environmentObject(self.resturantHelper)
            }
        }
        .onAppear{
            self.fireDBHelper.getUserDetails(userID: self.loginModel.auth.currentUser?.uid)
            // End of Vstack
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
