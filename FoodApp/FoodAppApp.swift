//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

@main
struct FoodAppApp: App {
    //let persistenceController = PersistenceController.shared
    let locationhelper : LocationHelper = LocationHelper()
    var body: some Scene {
        WindowGroup {
            //SearchBar()
            ContentView()
                .environmentObject(locationhelper)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
