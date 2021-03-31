//
//  WeatherStruct.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import Foundation

struct cities: Codable{
    let name: String
    let country: String
    let coord: coordinates
    
}
struct coordinates: Codable{
    let lon: Double
    let lat: Double
}

struct weatherData: Codable {
    let current: currentWeather
    let hourly: [hourlyData]
    let daily: [dailyData]
}

struct dailyData: Codable {
    let dt: Date
    let temp: tempData
    let weather: [weather]
}

struct tempData: Codable {
    let max: Double
    let min: Double
}

struct currentWeather: Codable {
    let temp: Double
    let weather: [weather]
    
}
struct hourlyData: Codable {
    let dt: Date
    let temp: Double
    let weather: [weather]
}

struct weather: Codable {
    let description: String
    let id: Int
    let icon: String
}

struct WeatherSettings{
    static var cityName = "Toronto"
    static var lon = -79.4163
    static var lat = 43.7001
    static var degree = DegreeType.metric
    static var group = DispatchGroup()
    static var searchGroup = DispatchGroup()
    
}

struct CityInformation{
    static var cities = [City]()
}

enum DegreeType {
    case metric
    case imperial
    case kelvin
}


