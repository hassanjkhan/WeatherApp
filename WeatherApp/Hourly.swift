//
//  Hourly.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import Foundation

class Hourly {
    var icon: String
    var temp: Double
    var time: Int
    
    init(icon: String, temp: Double, time: Int){
        self.icon = icon
        self.temp = temp
        self.time = time
    }
    
    
    func getTemp() -> String{
        return String(format: "%.0f", temp)
    }
    
    func getTime() -> String {
        if time == 0 {
            return "12 AM"
        }
        if time == 12 {
            return "12 PM"
        }
        if time < 12{
            return String(time) + " AM"
        }        
        return String(time - 12) + " PM"
        
    }
    

}
