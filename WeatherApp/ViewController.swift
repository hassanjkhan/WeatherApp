//
//  ViewController.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var degreeUIButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var hourlyWeatherScrollView: UIScrollView!
    @IBOutlet weak var currentIcon: UIImageView!
    
    @IBOutlet weak var firstDayLabel: UILabel!
    @IBOutlet weak var firstDayIcon: UIImageView!
    @IBOutlet weak var firstDayMaxTempLabel: UILabel!
    @IBOutlet weak var firstDayMinTempLabel: UILabel!
    
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var secondDayIcon: UIImageView!
    @IBOutlet weak var secondDayMaxTempLabel: UILabel!
    @IBOutlet weak var secondDayMinTempLabel: UILabel!
    
    @IBOutlet weak var thirdDayLabel: UILabel!
    @IBOutlet weak var thirdDayIcon: UIImageView!
    @IBOutlet weak var thirdDayMaxTempLabel: UILabel!
    @IBOutlet weak var thirdDayMinTempLabel: UILabel!
    
    @IBOutlet weak var fourthDayLabel: UILabel!
    @IBOutlet weak var fourthDayIcon: UIImageView!
    @IBOutlet weak var fourthDayMaxTempLabel: UILabel!
    @IBOutlet weak var fourthDayMinTempLabel: UILabel!
    
    @IBOutlet weak var fifthDayLabel: UILabel!
    @IBOutlet weak var fifthDayIcon: UIImageView!
    @IBOutlet weak var fifthDayMaxTempLabel: UILabel!
    @IBOutlet weak var fifthDayMinTempLabel: UILabel!
    
    var controller: WeatherController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        minTempLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 4.0).isActive = true
        maxTempLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor,constant: -4.0).isActive = true
        setData()
        hourlyWeatherScrollView.layer.borderWidth = 1
        hourlyWeatherScrollView.layer.borderColor = CGColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
     
    }
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        stack.alignment = .leading
        stack.spacing = 5
        stack.axis = .horizontal
        return stack
    }()
    
    
    @IBAction func degreeButtonAction(_ sender: Any) {
        
        switch WeatherSettings.degree{
        case .metric:
            degreeUIButton.setTitle("F°", for: .normal)
            WeatherSettings.degree = .imperial
            
        case .imperial:
            degreeUIButton.setTitle("K°", for: .normal)
            WeatherSettings.degree = .kelvin
        case .kelvin:
            degreeUIButton.setTitle("C°", for: .normal)
            WeatherSettings.degree = .metric
        }

        setData()
        
    }
    
    
    func setDailyWeather(){
        
        let daily = controller.getDailyWeather()
        
        currentIcon.image = UIImage(named: daily[0].icon)
        firstDayLabel.text = daily[1].day
        firstDayMaxTempLabel.text = daily[1].getMaxTemp() + "°"
        firstDayMinTempLabel.text = daily[1].getMinTemp() + "°"
        firstDayIcon.image = UIImage(named: daily[1].icon)
        
        secondDayLabel.text = daily[2].day
        secondDayMaxTempLabel.text = daily[2].getMaxTemp() + "°"
        secondDayMinTempLabel.text = daily[2].getMinTemp() + "°"
        secondDayIcon.image = UIImage(named: daily[2].icon)
        
        thirdDayLabel.text = daily[3].day
        thirdDayMaxTempLabel.text = daily[3].getMaxTemp() + "°"
        thirdDayMinTempLabel.text = daily[3].getMinTemp() + "°"
        thirdDayIcon.image = UIImage(named: daily[3].icon)
        
        
        fourthDayLabel.text = daily[4].day
        fourthDayMaxTempLabel.text = daily[4].getMaxTemp() + "°"
        fourthDayMinTempLabel.text = daily[4].getMinTemp() + "°"
        fourthDayIcon.image = UIImage(named: daily[4].icon)
        
        fifthDayLabel.text = daily[5].day
        fifthDayMaxTempLabel.text = daily[5].getMaxTemp() + "°"
        fifthDayMinTempLabel.text = daily[5].getMinTemp() + "°"
        fifthDayIcon.image = UIImage(named: daily[5].icon)
        
    }
    
    func setCurrentWeather(){
        locationLabel.text = WeatherSettings.cityName
        descriptionLabel.text = controller.getCurrentDescription()
        currentTempLabel.text = controller.getCurrentTemp() + "°"
        minTempLabel.text = "L:" + controller.getTodayMinTemperature()  + "°"
        maxTempLabel.text = "H:" + controller.getTodayMaxTemperature()  + "°"
        
    }
    
    func setHourlyWeather(){
        let hourly = controller.getHourlyWeather()
        hourlyWeatherScrollView.addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: hourlyWeatherScrollView.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: hourlyWeatherScrollView.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: hourlyWeatherScrollView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: hourlyWeatherScrollView.bottomAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: hourlyWeatherScrollView.heightAnchor).isActive = true
        
        for eachHour in hourly {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let timeLabel = UILabel()
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            timeLabel.text = eachHour.getTime()
            timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            timeLabel.adjustsFontSizeToFitWidth = true
            timeLabel.minimumScaleFactor = 0.1
            timeLabel.textColor = .white
            timeLabel.textAlignment = .center
            
            
            let icon = UIImageView()
            icon.image = UIImage(named: eachHour.icon)
            icon.translatesAutoresizingMaskIntoConstraints = false
            
            
            let temp = UILabel()
            temp.text = eachHour.getTemp() + "°"
            temp.translatesAutoresizingMaskIntoConstraints = false
            temp.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            temp.adjustsFontSizeToFitWidth = true
            temp.minimumScaleFactor = 0.1
            temp.textColor = .white
            temp.textAlignment = .center
            
            stack.addArrangedSubview(view)
            
            view.topAnchor.constraint(equalTo: hourlyWeatherScrollView.topAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: 60).isActive = true
            view.bottomAnchor.constraint(equalTo: hourlyWeatherScrollView.bottomAnchor).isActive = true
            
            view.addSubview(timeLabel)
            
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            view.addSubview(icon)
            view.addSubview(temp)
            icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
            icon.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            icon.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            icon.bottomAnchor.constraint(equalTo: temp.topAnchor).isActive = true
            
            temp.heightAnchor.constraint(equalToConstant: 20).isActive = true
            temp.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            temp.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        }
        
        
    }
    
    func setData(){
        for s in stack.arrangedSubviews {
            stack.removeArrangedSubview(s)
            s.removeFromSuperview()
        }
        controller = WeatherController()
        controller.fetchWeather()
        
        WeatherSettings.group.notify(queue: .main) {
            self.setDailyWeather()
            self.setCurrentWeather()
            self.setHourlyWeather()
            
        }
    }
    
}

