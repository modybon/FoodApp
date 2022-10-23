//
//  ContentView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView(){
            HomeView().tabItem{
                Image(systemName: "house.fill")
                Text("Home")
            }
            BrowseView().tabItem{
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
            BasketView().tabItem{
                Image(systemName: "cart.fill")
                Text("Baskets")
            }
            OrdersView().tabItem{
                Image(systemName: "list.bullet.rectangle.portrait.fill")
                Text("Orders")
            }
            AccountView().tabItem{
                Image(systemName: "person.fill")
                Text("Account")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
