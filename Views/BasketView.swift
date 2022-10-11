//
//  BasketView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct BasketView: View {
    let grayColor : Color = Color(red: 0.917, green: 0.908, blue: 0.911, opacity: 1)
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

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
