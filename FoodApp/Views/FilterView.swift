//
//  FilterView.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-11-26.
//

import SwiftUI

struct FilterView: View {
    @State var value : Float = 2.99
    @State var isVegetarian : Bool = false
    @State var isVegan : Bool = false
    @State var isGlutenFree : Bool = false
    @State var isHalal : Bool = false
    @State var isAllergyFree : Bool = false
    @State var isFirstValue : Bool = true
    @State var isSecondValue : Bool = false
    @State var isThirdValue : Bool = false
    @State var dietryOptions : [DietryOptions] = [DietryOptions]()
    @EnvironmentObject var locationHelper : LocationHelper
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment:.leading){
            Image(systemName: "xmark").font(.title).padding([.bottom,.top]).onTapGesture {

                self.locationHelper.filterHelper.dietOptions = ""
                if(self.isVegetarian){
                    self.locationHelper.filterHelper.dietOptions += ", \(DietryOptions.vegetarian.rawValue)"
                }
                if(self.isVegan){
                    self.locationHelper.filterHelper.dietOptions += ", \(DietryOptions.vegan.rawValue)"
                }
                if(self.isHalal){
                    self.locationHelper.filterHelper.dietOptions += ", \(DietryOptions.halal.rawValue)"
                }
                if(self.isGlutenFree){
                    self.locationHelper.filterHelper.dietOptions += ", \(DietryOptions.glutenFree.rawValue)"
                }
                if(self.isAllergyFree){
                    self.locationHelper.filterHelper.dietOptions += ", \(DietryOptions.allergyFree.rawValue)"
                }
                if(!self.isVegetarian && !self.isVegan && !self.isGlutenFree && !self.isAllergyFree && !self.isAllergyFree){
                    self.locationHelper.filterHelper.dietOptions = "food"
                }
                self.locationHelper.filterHelper.maxDeliveryFee = self.value
                print(#function,"Filter:\(self.locationHelper.filterHelper.dietOptions)")
                print(#function,"Filter:\( self.locationHelper.filterHelper.maxDeliveryFee)")
                self.locationHelper.preformResturantsSearch()
                dismiss()
            }
            Text("Max.Delivery Fee").font(.title).padding(.bottom,5)
            HStack{
                Text("$3").fontWeight(.bold).opacity((isFirstValue == true) ? 1 : 0.5)
                Spacer()
                Text("$4").fontWeight(.bold).opacity((isSecondValue == true) ? 1 : 0.5)
                Spacer()
                Text("$5").fontWeight(.bold).opacity((isThirdValue == true) ? 1 : 0.5)
            }.frame(maxWidth:.infinity)
            Slider(value: $value, in: 2.99 ... 5,step: 1).onChange(of: value){newValue in
                isFirstValue = (newValue == 2.99) ? true : false
                isSecondValue = (newValue == 3.99) ? true : false
                isThirdValue = (newValue == 4.99) ? true : false
            }
            //Text("\(value)")
            Text("Dietry").font(.title)
            List{
                Button(action:{
                    self.isVegetarian.toggle()
                    if(self.isVegetarian){
                        self.dietryOptions.append(DietryOptions.vegetarian)
                        print("Added: \(DietryOptions.vegetarian)")
                    }else{
                        if let index = self.dietryOptions.firstIndex(of: DietryOptions.vegetarian) {
                            self.dietryOptions.remove(at: index)
                        }
                    }
                }){
                    HStack{
                        HStack{
                            Image(systemName: "leaf.fill")
                            Text("\(DietryOptions.vegetarian.rawValue)")
                        }
                        Spacer()
                        Image(systemName: "checkmark.circle").opacity((self.isVegetarian) ? 1 : 0)
                    }
                }
                Button(action:{
                    self.isVegan.toggle()
                    if(self.isVegan){
                        self.dietryOptions.append(DietryOptions.vegan)
                        print("Added: \(DietryOptions.vegan)")
                    }else{
                        if let index = self.dietryOptions.firstIndex(of: DietryOptions.vegan) {
                            self.dietryOptions.remove(at: index)
                        }
                    }
                }){
                    HStack{
                        HStack{
                            Image("eco-friendly").resizable()
                                .frame(width: 20, height: 20)
                            Text("Vegan")
                        }
                        Spacer()
                        Image(systemName: "checkmark.circle").opacity((self.isVegan) ? 1 : 0)
                    }
                }
                Button(action:{
                    self.isGlutenFree.toggle()
                    if(self.isGlutenFree){
                        self.dietryOptions.append(DietryOptions.glutenFree)
                        print("Added: \(DietryOptions.glutenFree)")
                    }else{
                        if let index = self.dietryOptions.firstIndex(of: DietryOptions.glutenFree) {
                            self.dietryOptions.remove(at: index)
                        }
                    }
                }){
                    HStack{
                        HStack{
                            Image("gluten-free").resizable()
                                .frame(width: 20, height: 20)
                            Text("Gluten Free")
                        }
                        Spacer()
                        Image(systemName: "checkmark.circle").opacity((self.isGlutenFree) ? 1 : 0)
                    }
                }
                Button(action:{
                    self.isHalal.toggle()
                    if(self.isHalal){
                        self.dietryOptions.append(DietryOptions.halal)
                        print("Added: \(DietryOptions.halal)")
                    }else{
                        if let index = self.dietryOptions.firstIndex(of: DietryOptions.halal) {
                            self.dietryOptions.remove(at: index)
                        }
                    }
                }){
                    HStack{
                        HStack{
                            Image("Halal_BW")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Halal")
                        }
                        Spacer()
                        Image(systemName: "checkmark.circle").opacity((self.isHalal) ? 1 : 0)
                    }
                }
                Button(action:{
                    self.isAllergyFree.toggle()
                    if(self.isAllergyFree){
                        self.dietryOptions.append(DietryOptions.allergyFree)
                        print("Added: \(DietryOptions.allergyFree)")
                    }else{
                        if let index = self.dietryOptions.firstIndex(of: DietryOptions.allergyFree) {
                            self.dietryOptions.remove(at: index)
                        }
                    }
                }){
                    HStack{
                        HStack{
                            Image("peanut-free").resizable()
                                .frame(width: 20, height: 20)
                            Text("Allergy Free")
                        }
                        Spacer()
                        Image(systemName: "checkmark.circle").opacity((self.isAllergyFree) ? 1 : 0)
                    }
                }
            }.listStyle(.plain)
        }
        .onAppear{
            self.isVegetarian = (self.locationHelper.filterHelper.dietOptions.contains("\(DietryOptions.vegetarian.rawValue)")) ? true : false
            self.isVegan = (self.locationHelper.filterHelper.dietOptions.contains("\(DietryOptions.vegan.rawValue)")) ? true : false
            self.isHalal = (self.locationHelper.filterHelper.dietOptions.contains("\(DietryOptions.halal.rawValue)")) ? true : false
            self.isAllergyFree = (self.locationHelper.filterHelper.dietOptions.contains("\(DietryOptions.allergyFree.rawValue)")) ? true : false
            self.isGlutenFree = (self.locationHelper.filterHelper.dietOptions.contains("\(DietryOptions.glutenFree.rawValue)")) ? true : false
            self.value = self.locationHelper.filterHelper.maxDeliveryFee
        }
        .padding([.leading,.trailing])
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}


//                        for index in self.dietryOptions.indices {
//                            print(index)
//                            if(self.dietryOptions[index] == DietryOptions.vegan){
//                                print("Removed :\(self.dietryOptions[index].rawValue)")
//                                self.dietryOptions.remove(at: index)
//                            }
//                        }
