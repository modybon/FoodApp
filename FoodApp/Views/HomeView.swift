//
//  HomeView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct HomeView: View {
    let orangeColor = Color(red: 0.968, green: 0.546, blue: 0.461)
    @State var searchResturant : String = ""
    @State var orderMethod : OrderMethod = .Delivery
    @State var deleveryBtnIsDisabled : Bool = true
    @State var pickupBtnIsDisabled : Bool = false
    var body: some View {
        VStack{
            HStack{
                Rectangle()
                .cornerRadius(15)
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50, alignment: .center)
                .overlay(
                    Image(systemName: "person.fill").font(.system(size: 45))
                )
                VStack(alignment:.leading){
                    Text("Deliver to").foregroundColor(.orange)
                    Text("Last Name, First Name").underline()
                }
            }.frame(maxWidth:.infinity,alignment:.leading).padding(.leading)
            
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
                    )

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
                    )
            }
            Button(action: {}){
                HStack{
                    Text("Now · Current Location").foregroundColor(.black)
                    Image(systemName: "arrowtriangle.down.fill").foregroundColor(.black)
                }
                
            }
            
            Spacer()
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
