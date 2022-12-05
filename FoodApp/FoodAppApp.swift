//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI
import Firebase

@main
struct FoodAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    //let persistenceController = PersistenceController.shared
    
    let locationhelper : LocationHelper = LocationHelper()
    var body: some Scene {
        WindowGroup {
            //SearchBar()
            //ContentView()
            //  .environmentObject(locationhelper)
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            let loginModel = AppViewModel()
            let fireDBHelper = FireDBHelper(database: Firestore.firestore())
            startView()
                .environmentObject(loginModel)
                .environmentObject(locationhelper)
                .environmentObject(fireDBHelper)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        FirebaseApp.configure()
        
        return true
    }
}
