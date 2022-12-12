//
//  MenuItemDetails.swift
//  FoodApp
//
//  Created by Mohamed Fahmy on 2022-12-11.
//

import SwiftUI

struct MenuItemDetails: View {
    var isShowingView : Binding<Bool>
    var item : MenuItem
    @State var qty : Int = 1
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var orderHelper : OrderHelper
    var body: some View {
        VStack(alignment:.leading){
            Image(systemName: "xmark").font(.title).padding([.bottom,.top]).onTapGesture {
                self.isShowingView.wrappedValue = false
                dismiss()
            }.padding(.leading)
            Image(systemName: "person.fill").font(.system(size: 200)).frame(width: UIScreen.main.bounds.width)
            VStack(alignment:.leading){
                Text(item.name).font(.title).fontWeight(.bold)
                Text("$\(String(format: "%.2f", item.price))").font(.title3).fontWeight(.medium)
                Stepper("\(self.qty)", value: $qty, in: 1...10)
            }.padding([.trailing,.leading])
            Spacer()
            Rectangle().foregroundColor(.black).overlay(
                Button(action:{
                    self.orderHelper.addOrder(order: Order(totalPrice: Float(self.qty) * item.price, qty: self.qty,item: item))
                    self.isShowingView.wrappedValue = false
                    dismiss()
                }){
                    Text("Add to Cart \(self.qty) · $\(String(format: "%.2f", Float(self.qty) * self.item.price))").foregroundColor(.white).font(.title3)
                }.frame(maxWidth:.infinity)
            )
            .padding([.leading,.trailing])
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60)
        }
    }
}

//struct MenuItemDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemDetails()
//    }
//}
