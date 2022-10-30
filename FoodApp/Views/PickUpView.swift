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
    @StateObject var locationViewModel = LocationViewModel()
    @State var currentLatitude : Double = 0
    @State var currentLongitude : Double = 0

    var body: some View {
        VStack{
            switch self.locationViewModel.authorizationStatus {
            case .notDetermined:
                Text("Not Determined").onAppear{
                    locationViewModel.requestPermission()
                }
            case .restricted:
                Text("Restricted")
            case .denied:
                Text("Denied").onAppear{
                    locationViewModel.requestPermission()
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
                    Map(coordinateRegion: self.$locationViewModel.region, showsUserLocation: true)
                    ZStack{
                        Rectangle()
                            .foregroundColor((slideOverIsExpanded) ? .white : .clear)
                            .frame(width: UIScreen.main.bounds.width, height: 80)
                        SearchBar(searchText:$searchText,filterAvailble:true,title: "Food,Drink,etc.", color: (slideOverIsExpanded) ? .gray.opacity(0.3) : .white)
                    }
                }
                SlideOverView(isFullyExtended: self.$slideOverIsExpanded){
                    VStack{
                        Text("Lattitude: \(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0)")
                        Text("Longitude: \(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)")
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
                            ResturantView().listRowSeparator(.hidden)
                            ResturantView()
                            ResturantView()
                        }.listStyle(.grouped)
                    }
                }
            }
            //Spacer()
        }.onAppear{
            self.currentLongitude = locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0
            self.currentLatitude = locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0
        }
    }
}

struct PickUpView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpView()
    }
}
