//
//  CartOrderView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-11.
//

import SwiftUI

struct CartOrderView: View {
    var body: some View {
        ///
        HStack{
            Image(systemName: "beats.fit.pro.chargingcase.fill").font(.system(size: 50))
            VStack(alignment:.leading){
                Text("Pizza Depot").bold().font(.system(size: 20))
                HStack{
                    Text("1 item")
                    Image(systemName: "circle.fill").font(.system(size: 5))
                    Text("$36.84")
                }
                Text("Deliver to 1400 traflgar")
            }.frame(minWidth:200,maxWidth: .infinity)
        }
    }
}

struct CartOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CartOrderView()
    }
}
