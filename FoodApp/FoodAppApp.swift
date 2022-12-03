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
    let filterHelper : FilterHelper = FilterHelper()
    //let locationhelper : LocationHelper = LocationHelper(filterHelper: <#T##FilterHelper#>)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocationHelper(filterHelper: filterHelper))
                .environmentObject(filterHelper)
            //FilterView()
            //DeliveringOrderView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
