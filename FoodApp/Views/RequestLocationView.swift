//
//  RequestLocationView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-29.
//

import SwiftUI

struct RequestLocationView: View {
    var body: some View {
        VStack{
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.blue)
            Button(action: {
                print(#function,"Allowing Perms")
            }){
                Label("Allow tracking", systemImage: "location").foregroundColor(.black)
            }
            .padding(10)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("We need your permission to track you.")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationView()
    }
}
