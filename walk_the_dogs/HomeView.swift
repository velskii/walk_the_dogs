

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
            HealthView()
                .tag(0)
                .tabItem{
                    Text("Walking Steps")
                    Image(systemName: "figure.walk")
                }
            WeatherView( )
               .tag(1)
               .tabItem {
                   Text("Weather")
                   Image(systemName: "sun.dust.fill")
               }
            MessageView()
               .tag(2)
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
