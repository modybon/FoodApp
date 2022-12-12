//
//  DeliveringOrderView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-24.
//

import SwiftUI
import MapKit
struct DeliveryOrderView: View {
    @State var isFullyExtended : Bool = false
    var currentUserPosition : Binding<CLLocation?>
    var restaurantPosition : CLLocation
    var restaurant : Restaurant
    var orders : [Order]
    var body: some View {
        VStack(alignment:.leading){
            ZStack(alignment:.top){
                DeliveringMapView(currentUserPosition: currentUserPosition, restaurantPosition: restaurantPosition)
                SlideOverView(isFullyExtended: self.$isFullyExtended){
                    VStack(alignment:.leading,spacing: 30){
                        HStack(spacing: 30){
                            ZStack{
                                Image(systemName: "car.fill").font(.title).offset(x: 23)
                                Image(systemName: "person.fill").font(.title)
                            }
                            VStack(alignment:.leading){
                                HStack(spacing:7){
                                    Text("Mohamed").foregroundColor(.green)
                                    Text("CKSU218")
                                }
                                Text("Honda Civic")
                            }
                        }
                        VStack(alignment:.leading){
                            Text("Order Summary").font(.title3).fontWeight(.bold)
                            Text(self.restaurant.name).font(.caption).foregroundColor(.gray)
                            ForEach(self.orders){ order in
                                HStack{
                                    Rectangle()
                                        .foregroundColor(.gray.opacity(0.3))
                                        .overlay(
                                            Text("\(order.qty)").foregroundColor(.black)
                                        ).frame(width: 25, height: 25)
                                    Text("\(order.item.name)")
                                }
                            }
                        }
                        Spacer()
                    }
                    }.frame(maxWidth: UIScreen.main.bounds.width)
            }
        }
    }
}
//
//struct DeliveringOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeliveryOrderView()
//    }
//}
