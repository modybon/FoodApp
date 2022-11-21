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
        let resturants : [ResturantPin] = [
            ResturantPin(name: "MacDonalds", location:CLLocationCoordinate2D(latitude: 37.714334 - 0.0002123123 , longitude: -122.408227 - 0.00123123123 ), rating: 4.3),
            ResturantPin(name: "Burger King", location:CLLocationCoordinate2D(latitude: 37.714334 - 0.000219723492 , longitude: -122.408227 - 0.0017623452 ), rating: 3.9),
            ResturantPin(name: "Pizza Dominos", location:CLLocationCoordinate2D(latitude: 37.714334 - 0.000523423 , longitude: -122.408227 - 0.0012342342 ), rating: 5.0),
            ResturantPin(name: "Paradise Chicken", location:CLLocationCoordinate2D(latitude: 37.714334 - 0.000264533 , longitude: -122.408227 - 0.0012921638721 ), rating: 4.7)
        ]
        VStack{
            switch self.locationHelper.authorizationStatus {
            case .notDetermined:
                Text("Not Determined").onAppear{
                    locationHelper.requestPermission()
                }
            case .restricted:
                Text("Restricted")
            case .denied:
                Text("Denied").onAppear{
                    locationHelper.requestPermission()
                }
            case .authorized:
                Text("Authorized")
            case .authorizedAlways:
                Text("Alway Authorized")
            case .authorizedWhenInUse:
                Text("")
            @unknown default:
                fatalError()
            }
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
                        Text("Lattitude: \(locationHelper.currentLocation?.coordinate.latitude ?? 0)")
                        Text("Longitude: \(locationHelper.currentLocation?.coordinate.longitude ?? 0)")
                        Text("Resturant Name: \(self.$resturantHelper.currentResturantMapItem.wrappedValue?.name ?? "NA")")
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
                        List{
                            ResturantView(resturantName: "mac").listRowSeparator(.hidden)
                            ResturantView(resturantName: "mac")
                            ResturantView(resturantName: "mac")
                        }.listStyle(.grouped)
                    }
                }
            }
            //Spacer()
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
