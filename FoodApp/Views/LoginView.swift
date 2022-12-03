//
//  LoginView.swift
//  FoodApp
//
//  Created by Timothy Dow on 2022-11-04.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email Address", text: $email)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Password", text: $password)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button(action: {
                    
                }, label: {
                    Text("Log In")
                        .frame(width:200, height:50)
                        .cornerRadius(8)
                })
            }
            .navigationTitle("Log In")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

