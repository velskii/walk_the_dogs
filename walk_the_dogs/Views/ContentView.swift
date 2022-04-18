/*
Filename:   ContentView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter
        
    var body: some View {
        
        switch viewRouter.currentPage
        {
        case .login:
            LoginView(viewRouter: viewRouter)
        case .register:
            RegisterView(viewRouter: viewRouter)
        case .home:
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}
