//
//  ResturantView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-13.
//

import SwiftUI

struct ResturantView: View {
    var body: some View {
        VStack(alignment:.leading){
            ZStack{
                Image(systemName: "person.fill")
                    .frame(maxWidth:.infinity,minHeight: 150)
                    .font(.system(size: 180))
                // TODO: HEART SHAPE BUTTON TO FOR FAVOURITE RESTURANTS
            }
            
            HStack{
                VStack(alignment:.leading){
                    Text("Macdonald's")
                    Text("$0.99 Delivery Fee 20-35 min")
                }
                Spacer()
                Circle()
                    .stroke(lineWidth: 0)
                    .frame(width: 30, height: 30)
                    .background(Circle().foregroundColor(.gray.opacity(0.2)))
                    .overlay{
                        Text("4.6")
                    }
                    
            }
        }
        .padding()
        .background(Rectangle().stroke().cornerRadius(20).border(.black, width: 4))
        .padding()
    }
}

struct ResturantView_Previews: PreviewProvider {
    static var previews: some View {
        ResturantView()
    }
}
