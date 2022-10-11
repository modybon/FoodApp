//
//  OrdersView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct OrdersView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment:.leading,spacing: 20){
                    Text("Past orders").font(.system(size: 20)).fontWeight(.medium)
                    VStack{
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                        PastOrderView()
                    }
                }
            }.navigationBarTitleDisplayMode(.automatic).toolbar{
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Your orders").font(.headline)
                    }
                }
            }
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
