//
//  LoginView.swift
//  FoodApp
//
//  Created by Timothy Dow on 2022-11-04.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
 
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
}

struct startView: View {
    @EnvironmentObject var loginModel: AppViewModel
    @EnvironmentObject var locationHelper : LocationHelper
    var body: some View{
        NavigationView{
            if loginModel.signedIn {
                ContentView()
            }
            else {
                LoginView()
            }
        }
        .onAppear {
            loginModel.signedIn = loginModel.isSignedIn
        }
    }
}

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var loginModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email Address", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    loginModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Log In")
                        .frame(width:200, height:50)
                        .cornerRadius(8)
                })
                
                NavigationLink("Sign Up", destination: SignupView())
            }
        }
        .navigationTitle("Log In")
    }
}

struct SignupView: View {
    @State var uName = ""
    @State var uPhone = ""
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var loginModel: AppViewModel
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Full Name", text: $uName)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                TextField("Phone Number", text: $uPhone)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                TextField("Email Address", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty, !uName.isEmpty, !uPhone.isEmpty  else {
                        return
                    }
                   
                    loginModel.signUp(email: email, password: password)
                   
                    
                    
                }, label: {
                    Text("Create Account")
                        .frame(width:200, height:50)
                        .cornerRadius(8)
                })
            }
            
        }
        .navigationTitle("Create Account")
        .onDisappear(){
            var insertUser = User(id: String(loginModel.auth.currentUser!.uid),uName: uName, email: email, phone: uPhone, favRes: [""], savedAddresses: [""])
            self.fireDBHelper.insertUser(newUser: insertUser)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

