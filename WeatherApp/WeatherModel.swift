//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import Foundation

class WeatherModel {
    
    var currentTemperature: Double
    var currentDescription: String
    var todayMaxTemperature: Double
    var todayMinTemperature: Double
    var hourlyWeather: [Hourly]
    var dailyWeather: [DayWeather]
    
    init(){
        currentTemperature = 0
        currentDescription = ""
        todayMaxTemperature = 0
        todayMinTemperature = 0
        hourlyWeather = []
        dailyWeather = []
        parseJson()
    }
    
    func fetchWeatherData(){
        let lat = WeatherSettings.lat
        let lon = WeatherSettings.lon
        let degree = degreeToString()
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=" + String(lat) + "&lon=" + String(lon) + "&units=" + degree + "&exclude=minutely,alerts&appid=a94ace9be7994ce0beb8b5e27cefcd7b")!
        WeatherSettings.group.enter()
        URLSession.shared.dataTask(with: url, completionHandler: { [self] data, response, error in
            guard let data = data, error == nil else {
                print("Error Fetching Weather")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            var weather: weatherData?
            
            do {
                weather = try JSONDecoder().decode(weatherData.self, from: data)
            }
            catch {
                print("failed to convert to JSON \(error.localizedDescription)")
            }
            
            guard let json = weather  else {
                return
            }
            
            self.currentTemperature = json.current.temp
            self.currentDescription = json.current.weather[0].description
            self.todayMaxTemperature = json.daily[0].temp.max
            self.todayMinTemperature = json.daily[0].temp.min
            
            for EachHour in json.hourly {
                hourlyWeather.append(
                    Hourly(
                        icon: EachHour.weather[0].icon,
                        temp: EachHour.temp,
                        time: Calendar.current.component(.hour, from: EachHour.dt)
                    )
                )
            }
            
            for EachDay in json.daily {
                dailyWeather.append(
                    DayWeather(
                        icon: EachDay.weather[0].icon,
                        maxTemp: EachDay.temp.max,
                        minTemp: EachDay.temp.min,
                        day: self.getWeekDay(day: EachDay.dt.get(.weekday))
                    )
                )
            }
            
            
            WeatherSettings.group.leave()
        }).resume()
    }
    
    func degreeToString() -> String {
        
        switch WeatherSettings.degree{
        
        case .metric:
            return "metric"
        case .imperial:
            return "imperial"
        case .kelvin:
            return "kelvin"
        }
        
    }
    
    func getWeekDay(day: Int) -> String{
        
        switch day {
        
        case 1:
            return "Wednesday"
        case 2:
            return "Thursday"
        case 3:
            return "Friday"
        case 4:
            return "Saturday"
        case 5:
            return "Sunday"
        case 6:
            return "Monday"
        case 7:
            return "Tuesday"
        default:
            return ""
        }
    }
    
    /*
     Parses Json from city file and stores it in cityinformaton struct to be used by SearchResultTable
     */
    func parseJson(){
        if (CityInformation.cities.count <= 0){
            WeatherSettings.searchGroup.enter()
            DispatchQueue.global().async() {
                if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        
                        let citiesData = try JSONDecoder().decode([cities].self, from: data)
                        
                        for EachCity in citiesData {
                            CityInformation.cities.append(City.init(name: EachCity.name,
                                                                    country: EachCity.country,
                                                                    lon: EachCity.coord.lon,
                                                                    lat: EachCity.coord.lat))
                        }
                        WeatherSettings.searchGroup.leave()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
        
}
