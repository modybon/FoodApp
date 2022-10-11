//
//  PastOrderView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct PastOrderView: View {
    let grayColor : Color = Color(red: 0.917, green: 0.908, blue: 0.911, opacity: 1)
    var body: some View {
        HStack{
            Image(systemName: "beats.fit.pro.chargingcase.fill").font(.system(size: 70))
            VStack{
                Text("Pizza Depot")
                HStack{
                    Text("1 item")
                    Image(systemName: "circle.fill").font(.system(size: 5))
                    Text("$36.84")
                }
                HStack{
                    Text("Jul 01")
                    Image(systemName: "circle.fill").font(.system(size: 5))
                    Text("Completed").font(.system(size: 18))
                }
            }
            
            Rectangle()
                .frame(width: 95, height: 35)
                .cornerRadius(25)
                .foregroundColor(grayColor)
                .overlay(
                    Button(action: {}){
                        Text("View store").foregroundColor(.black).frame(maxWidth:.infinity,maxHeight: .infinity)
                    }
                )
        }
    }
}

struct PastOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PastOrderView()
    }
}
