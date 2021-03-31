//
//  City.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import Foundation

class City {
    let name: String
    let country: String
    let lon: Double
    let lat: Double
    
    init(name: String, country: String, lon: Double, lat: Double){
        self.name = name
        self.country = country
        self.lon = lon
        self.lat = lat
    }
    
}
