/*
Filename:   LoginView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI
import Firebase


struct LoginView : View {
    
    @StateObject var viewRouter: ViewRouter
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                
                UserImage()
                
                UsernameTextField(username: $username)
                
                PasswordSecureField(password: $password)
                
                if authenticationDidFail
                {
                    Text("Information not correct. Try again.")
                    .offset(y: -10)
                    .foregroundColor(.red)
                }
                
                Button(action: {
                    login()
                })
                {
                   LoginButtonContent()
                }
                Spacer()
                    .frame(height: 80)
                Text("No account yet? Register.")
                    .font(.system(size: 20))
                    .offset(y: -10)
                    .onTapGesture {
                        viewRouter.currentPage = .register
                    }
                
            }
            .padding()
            
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                self.authenticationDidFail = true
                print(error?.localizedDescription ?? "")
            } else {
                viewRouter.currentPage = .home
                self.authenticationDidFail = false
            }
        }
    }
    
        
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(viewRouter: ViewRouter())
//    }
//}


struct WelcomeText: View {
    var body: some View{
        return Text("Walking your dogs")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    
    var body: some View{
        
        return Image("corgi")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct UsernameTextField : View {
    
    @Binding var username: String
    
    var body: some View {
        return TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField : View {
    
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct RegisterButtonContent: View {
    var body: some View {
        return Text("REGISTER")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
