//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import Foundation

class WeatherController {
    
    var weatherModel: WeatherModel
    
    init(){
        self.weatherModel = WeatherModel()
    }
    
    func fetchWeather() {
        self.weatherModel.fetchWeatherData()
    }
    
    func getCurrentTemp() -> String {
        return String(format: "%.0f", weatherModel.currentTemperature)
    }
    
    func getCurrentDescription() -> String {
        return weatherModel.currentDescription
    }
    
    func getTodayMaxTemperature() -> String {
        return String(format: "%.0f", weatherModel.todayMaxTemperature)
    }
    
    func getTodayMinTemperature() -> String {
        return String(format: "%.0f", weatherModel.todayMinTemperature)
    }
    
    func getHourlyWeather() -> [Hourly]{
        return weatherModel.hourlyWeather
    }
    
    func getDailyWeather() -> [DayWeather]{
        return weatherModel.dailyWeather
    }
    
}
