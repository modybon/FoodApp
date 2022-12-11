//
//  PickUpView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct PickUpView: View {
    @State var orderMethod : OrderMethod = .Delivery
    @State var deleveryBtnIsDisabled : Bool = true
    @State var pickupBtnIsDisabled : Bool = false
    @State private var offset = CGSize.zero
    @State var whiteColorOpacity : Float = 0
    @State var slideOverIsExpanded : Bool = false
    @State var searchText: String = ""
    @EnvironmentObject var locationHelper : LocationHelper
    @State var currentLatitude : Double = 0
    @State var currentLongitude : Double = 0
    @EnvironmentObject var resturantHelper : ResturantHelper
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                Text("\(self.currentLongitude)")
                Text("\(self.currentLatitude)")
                ZStack(alignment:.topLeading){
                    CustomMapView().environmentObject(self.resturantHelper)
                    ZStack{
                        Rectangle()
                            .foregroundColor((slideOverIsExpanded) ? .white : .clear)
                            .frame(width: UIScreen.main.bounds.width, height: 80)
                        SearchBar(searchText:$searchText,filterAvailble:true,title: "Food,Drink,etc.", color: (slideOverIsExpanded) ? .gray.opacity(0.3) : .white)
                    }
                }
                SlideOverView(isFullyExtended: self.$slideOverIsExpanded){
                    VStack{
                        ScrollView(.horizontal){
                            LazyHStack(spacing:50){
                                VStack{
                                    Image("American")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("American")
                                }.onTapGesture {
                                    print("American")
                                }
                                VStack{
                                    Image("Asian")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Asian")
                                }.onTapGesture {
                                    print("Asian")
                                }
                                
                                VStack{
                                    Image("Halal")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Halal")
                                }.onTapGesture {
                                    print("Halal")
                                }
                                
                                VStack{
                                    Image("Bakery")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Bakery")
                                }.onTapGesture {
                                    print("Bakery")
                                }
                                
                                VStack{
                                    Image("Healthy")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("Healthy")
                                }.onTapGesture {
                                    print("Healthy")
                                }
                                
                            }.padding()
                        }.frame(maxWidth: UIScreen.main.bounds.width,maxHeight: 80)
                        if(!self.$locationHelper.resturantsList.isEmpty){
                            List{
                                ForEach(self.$locationHelper.resturantsList){ resturant in
                                    ResturantView(resturant: resturant.wrappedValue,isDelivery: false)
                                }
                            }.listStyle(.grouped)
                        }else{
                            Text("NO RESTURANTS NEAR BY 😢")
                        }
                    }
                }
            }// End of Zstack
            //Spacer()
        }// End of Vstack
    }
    var searchResults: [Resturant] {
        if searchText.isEmpty {
            return [Resturant]()
        } else {
            return self.locationHelper.resturantsList.filter { $0.name.contains(self.searchText)}
        }
    }
}

struct PickUpView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpView()
    }
}



//                    Map(coordinateRegion: self.$locationViewModel.region, interactionModes: [.all], showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: resturants){ place in
//                        MapAnnotation(coordinate:place.coordinate){
//                            Circle()
//                                .foregroundColor(.white)
//                                .frame(width:35,height: 35)
//                                .overlay(
//                                    Text("\(String(format: "%.1f", place.rating))").font(.caption)
//                                ).onTapGesture {
//                                    print("Resturant Tapped ")
//                                }
//                        }
//                    }
