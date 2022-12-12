//
//  ResturantView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-13.
//

import SwiftUI

struct RestaurantView: View {
    // TODO: if its being used in pickup view it will also show distance from the user location
    @EnvironmentObject var fireDBHelper: FireDBHelper
    @EnvironmentObject var loginModel: AppViewModel
    @State var isFavourite : Bool = false
    var resturant : Restaurant
    var isDelivery : Bool
    
    var body: some View {
        let heartImage : String = (self.isFavourite) ?  "heart.fill" : "heart"
        VStack(alignment:.leading){
            ZStack(alignment:.topTrailing){
                Image(systemName: "person.fill")
                    .frame(maxWidth:.infinity,minHeight: 150)
                    .font(.system(size: 180))
                Image(systemName: heartImage).font(.system(size: 40))
                    .foregroundColor((self.isFavourite) ? .red: nil)
                    .onTapGesture {
                        var addRestaurant: Bool
                        if(isFavourite == true){
                            addRestaurant = false
                            self.fireDBHelper.updateUserRes(addRes: self.resturant, addorDel: addRestaurant)
                            self.isFavourite.toggle()
                        }else{
                            addRestaurant = true
                            self.fireDBHelper.updateUserRes(addRes: self.resturant, addorDel: addRestaurant)
                            print("Tapped")
                            self.isFavourite.toggle()
                        }
                }
            }
            HStack{
                VStack(alignment:.leading){
                    Text("\(self.resturant.name)")
                    HStack{
                        if(isDelivery){
                            Text("$\(String(format:"%.2f",resturant.deliveryFee)) Delivery Fee")
                            Text("\(String(format:"%.f",((resturant.approxDeliveryTime)))) - \((String(format:"%.f",resturant.approxDeliveryTime + 5))) mins")
                        }else{
                            Text("10-15 mins")
                            Text("\(String(format:"%.1f",resturant.distanceFromCL)) Km")
                        }
                    }
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

//struct ResturantView_Previews: PreviewProvider {
//    @State var resturant : Resturant = Resturant()
//    static var previews: some View {
//        ResturantView(resturant: resturant)
//    }
//}
