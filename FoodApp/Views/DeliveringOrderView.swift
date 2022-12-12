//
//  DeliveringOrderView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-24.
//

import SwiftUI
import MapKit
struct DeliveringOrderView: View {
    @State var isFullyExtended : Bool = false
    var body: some View {
        VStack(alignment:.leading){
            Text("Preparing Your Order...").font(.largeTitle).fontWeight(.bold)
            Text("Estimated arrival 2:15 PM").font(.headline).foregroundColor(.gray)
            ZStack(alignment:.top){
                DeliveringMapView()
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
                            Text("Delivery Details").font(.title3).fontWeight(.bold)
                            Text("Address").font(.caption).foregroundColor(.gray)
                            Text("1400 traflgar rd, Oakville ON L6H 3L3, CA").font(.caption)
                        }
                        VStack(alignment:.leading){
                            Text("Order Summary").font(.title3).fontWeight(.bold)
                            Text("Macdonalds (270 Hays").font(.caption).foregroundColor(.gray)
                            HStack{
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.3))
                                    .overlay(
                                        Text("1").foregroundColor(.black)
                                    ).frame(width: 25, height: 25)
                                Text("Large Fries")
                            }
                            HStack{
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.3))
                                    .overlay(
                                        Text("1").foregroundColor(.black)
                                    ).frame(width: 25, height: 25)
                                Text("McChicken")
                            }
                            HStack{
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.3))
                                    .overlay(
                                        Text("2").foregroundColor(.black)
                                    ).frame(width: 25, height: 25)
                                Text("McFlurry")
                            }
                        }
                        Spacer()
                    }
                    }.frame(maxWidth: UIScreen.main.bounds.width)
            }
        }
    }
}

struct DeliveringOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveringOrderView()
    }
}
