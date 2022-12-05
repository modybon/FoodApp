//
//  PickUpOrderView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-12-03.
//

import SwiftUI
import MapKit
struct PickUpOrderView: View {
    var currentUserPosition : Binding<CLLocationCoordinate2D>
    var resturantPosition : CLLocationCoordinate2D
    @State var isFullyExtended : Bool = false
    var body: some View {
        ZStack{
            PickUpOrderMap(currentUserPosition: self.currentUserPosition, resturantPosition: resturantPosition)
            SlideOverView(isFullyExtended: self.$isFullyExtended){
                VStack(alignment:.leading,spacing: 30){
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
            }
        }
    }
}

//struct PickUpOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickUpOrderView()
//    }
//}
