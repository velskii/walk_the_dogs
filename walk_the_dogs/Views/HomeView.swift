/*
Filename:   HomeView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct HomeView: View {
    @State private var tabSelection = 0

    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(named: "Gray")
    }
    
    var body: some View{
        TabView(selection: $tabSelection)
        {
            TodoListView().environmentObject(TodoListViewModel())
                .tag(0)
                .tabItem{
                    Text("Schedule")
                    Image(systemName: "heart.text.square")
                }
            HealthView()
                .tag(1)
                .tabItem{
                    Text("Walking Steps")
                    Image(systemName: "figure.walk")
                }
            WeatherView( )
               .tag(2)
               .tabItem {
                   Text("Weather")
                   Image(systemName: "sun.dust.fill")
               }
            SettingsView( )
               .tag(3)
               .tabItem {
                   Text("Settings")
                   Image(systemName: "rectangle.and.pencil.and.ellipsis")
               }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
