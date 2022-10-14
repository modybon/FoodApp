//
//  HomeView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-10.
//

import SwiftUI

struct HomeView: View {
    let orangeColor = Color(red: 0.968, green: 0.546, blue: 0.461)
    @State var searchResturant : String = ""
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(.yellow)
                    .clipShape(Circle())
                    .frame(width: 75, height: 75, alignment: .center)
                VStack(alignment:.leading){
                    Text("Deliver to").foregroundColor(.orange)
                    Text("Last Name, First Name").underline().bold()
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
