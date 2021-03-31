//
//  DayWeather.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import Foundation

class DayWeather {
    var icon: String
    var maxTemp: Double
    var minTemp: Double
    var day: String
    
    init(icon: String, maxTemp: Double, minTemp: Double, day: String){
        self.icon = icon
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.day = day
    }
    
    func getMaxTemp() -> String{
        return String(format: "%.0f", maxTemp)
    }
    
    func getMinTemp() -> String{
        return String(format: "%.0f", minTemp)
    }
}
