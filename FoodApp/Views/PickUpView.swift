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
                RoundedRectangle(cornerRadius: 2.5)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay(
                        VStack{
                            RoundedRectangle(cornerRadius: 2.5)
                                .frame(width: 40, height: 5.0)
                                .foregroundColor(.black)
                                .padding(10)
                            Image(systemName: "person.fill").font(.system(size: 160))
                        }.frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
                    )
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
