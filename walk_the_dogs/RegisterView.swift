/*
Filename:   RegisterView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-03-25.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI


struct RegisterView : View {
    
    @StateObject var viewRouter: ViewRouter
    
    
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
                    // TODO
                    
                })
                {
                   RegisterButtonContent()
                }
                
                Button(action: {
                    viewRouter.currentPage = .login
                })
                {
                   LoginButtonContent()
                }
                
            }
            .padding()
            
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
