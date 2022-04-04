//
//  HomeView.swift
//  walk_the_dogs
//
//  Created by Jerry on 2022-04-03.
//

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
            WeatherView( )
               .tag(0)
               .tabItem {
                   Text("Weather")
                   Image(systemName: "sun.dust.fill")
               }
           MessageView()
               .tag(1)
               .tabItem {
                   Text("Messages")
                   Image(systemName: "plus.message")
               }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
