//
//  PickUpView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-24.
//

import SwiftUI
import MapKit

struct PickUpView: View {
    @State var orderMethod : OrderMethod = .Delivery
    @State var deleveryBtnIsDisabled : Bool = true
    @State var pickupBtnIsDisabled : Bool = false
    @State private var offset = CGSize.zero
    @State var whiteColorOpacity : Float = 0
    @State var slideOverIsExpanded : Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(
        latitude: 40.83834587046632,
        longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03)
    )
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                ZStack(alignment:.topLeading){
                    Map(coordinateRegion: $region)
                    ZStack{
                        Rectangle()
                            .foregroundColor((slideOverIsExpanded) ? .white : .clear)
                            .frame(width: UIScreen.main.bounds.width, height: 80)
                        SearchBar(color: (slideOverIsExpanded) ? .gray.opacity(0.3) : .white)
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
                        List{
                            ResturantView().listRowSeparator(.hidden)
                            ResturantView()
                            ResturantView()
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
