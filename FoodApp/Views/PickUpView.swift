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
                    SearchBar(color: .white)
                }
                SlideOverView{
                    VStack{
                        List{
                            ResturantView()
                            ResturantView()
                            ResturantView()
                        }
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
