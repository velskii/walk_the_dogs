/*
Filename:   RegisterView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-03-25.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI
import Firebase

struct RegisterView : View {
    
    @StateObject var viewRouter: ViewRouter
    @State var registerError: Bool = false
    
    @State var username: String = ""
    @State var password: String = ""
    @State var repeat_password: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                
                UsernameTextField(username: $username)
                
                PasswordSecureField(password: $password)
                
                RepeatPasswordSecureField(repeat_password: $repeat_password)
                
                
                Button(action: {
                    register()
                })
                {
                   RegisterButtonContent()
                }
                Spacer()
                    .frame(height: 80)
                Text("Already have an account? Login.")
                    .font(.system(size: 20))
                    .offset(y: -10)
                    .onTapGesture {
                        viewRouter.currentPage = .login
                    }
                
            }
            .padding()
            
        }
        .alert(isPresented: $registerError) {
            Alert(
                title: Text("Register Error"), message: Text("Error registering, please check your password and repeat password."), dismissButton: Alert.Button.cancel()
            )
        }.padding()
    }
    
    func register() {
        if repeat_password != password {
            self.registerError = true
        }
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if error != nil {
                self.registerError = true
            } else {
                viewRouter.currentPage = .login
            }
            
        }
    }
        
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewRouter: ViewRouter())
    }
}

struct RepeatPasswordSecureField : View {
    
    @Binding var repeat_password: String
    
    var body: some View {
        return SecureField("Repeat Password", text: $repeat_password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
