//
//  LocationDetailsView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-10-26.
//

import SwiftUI

struct LocationDetailsView: View {
    @State var searchText : String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment:.leading){
            Image(systemName: "xmark")
                .foregroundColor(.black)
                .font(.system(size: 30,weight: .bold))
                .padding(.leading,35)
                .padding(.top,10)
                .onTapGesture {
                    dismiss()
                }
            SearchBar(searchText: $searchText, filterAvailble: false, title: "Enter Address", color: .gray.opacity(0.3))
                .padding([.leading])
                .padding([.top],10)
            VStack{
                Text("Nearby")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .frame(width:UIScreen.main.bounds.width,alignment: .leading)
                    .padding([.leading],30)
                HStack{
                    Image(systemName: "location.fill").font(.system(size: 30)).foregroundColor(.black)
                    VStack(alignment:.leading){
                        Text("Current Location").font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(.black)
                        Text("1400 traflgar rd, Oakville, ON L6H 3L3, CA").foregroundColor(.black)
                    }.padding([.top,.bottom])
                }.onTapGesture {
                    print("Tapped")
                }
            }
            VStack{
                Text("Saved Places")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .frame(width:UIScreen.main.bounds.width,alignment: .leading)
                    .padding([.leading],30)
                HStack{
                    Image(systemName: "pin.fill").font(.system(size: 30)).foregroundColor(.black)
                    VStack(alignment:.leading){
                        Text("234 Hays Blvd").font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(.black)
                        Text("Oakville, ON L6H 3L3, CA").foregroundColor(.black)
                    }.padding([.top,.bottom])
                    Spacer()
                    ZStack{
                        Circle().foregroundColor(.gray.opacity(0.3)).frame(width: 30, height: 30)
                        Image(systemName: "pencil").foregroundColor(.black)
                    }.onTapGesture {
                        print("Tapped")
                    }
                    
                }
                .padding([.leading,.trailing])
                .frame(width:UIScreen.main.bounds.width,alignment: .leading)
                .onTapGesture {
                    print("Tapped")
                }
            }
            Spacer()
        }
        
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailsView()
    }
}
