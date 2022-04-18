/*
Filename:   WeatherView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-18.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct WeatherView: View {
    
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack{
            if let weather = weather{
                
                ZStack(alignment: .leading) {
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(weather.name)
                                .bold()
                                .font(.title)
                            
                            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.light)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                VStack(spacing: 20) {
                                    Image(systemName: "cloud")
                                        .font(.system(size: 40))
                                    
                                    Text("\(weather.weather[0].main)")
                                }
                                .frame(width: 150, alignment: .leading)
                                
                                Spacer()
                                
                                Text(weather.main.feelsLike.roundDouble() + "°")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .padding()
                            }
                            
                            Spacer()
                                .frame(height:  10)
                            
                            AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 350)
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                                .frame(height:  330)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Weather now")
                                .bold()
                                .padding(.bottom)
                            
                            HStack {
                                WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                                Spacer()
                                WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                            }
                            
                            HStack {
                                WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                                Spacer()
                                WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .background(Color.gray)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        Spacer()
                            .frame(height:  100)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .background(.white)
                
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        await getWeather(city: "Toronto")
                    }
            }
        }
        .background(.white)
    }
    
    func getWeather(city: String) async {
        do {
            weather = try await weatherManager.getCurrentWeather(city: city)
        } catch {
            print("Error getting weather: \(error)")
        }
    }
    func convertFarenheitToCelsius(fahrenheit: String) -> String{
        return String(format: "%f", (Double(fahrenheit) ?? 325 - 32) * 5 / 9 )
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

