//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI
import MapKit
@main
struct FoodAppApp: App {
    //let persistenceController = PersistenceController.shared
    let filterHelper : FilterHelper = FilterHelper()
    //let locationhelper : LocationHelper = LocationHelper(filterHelper: <#T##FilterHelper#>)
    @State var currentUserPosition = CLLocationCoordinate2D(latitude: 51.50998, longitude: -0.1337)
    var resturantPosition = CLLocationCoordinate2D(latitude: 51.59823673, longitude: -0.1337)
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(LocationHelper(filterHelper: filterHelper))
//                .environmentObject(filterHelper)
            PickUpOrderView(currentUserPosition: self.$currentUserPosition, resturantPosition: resturantPosition)
            //FilterView()
            //DeliveringOrderView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
