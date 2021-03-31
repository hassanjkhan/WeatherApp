//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Hassan Khan on 2021-03-30.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    var currentCities = [City]()
    
    @IBOutlet weak var citiesTable: UITableView! {
        didSet{
            citiesTable.delegate = self
            citiesTable.dataSource = self
            
            //citiesTable.register(CityTableViewCell.self, forCellReuseIdentifier: "Cell")
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet{
            searchTextField.addTarget(self, action: #selector(SearchCityViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        currentCities = [City]()
        updateTable(search: searchTextField.text ?? "")
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    func updateTable(search: String){
        
        for EachCity in CityInformation.cities {
            if(EachCity.name.lowercased().contains(search.lowercased())){
                self.currentCities.append(EachCity)
            }
        }
        
        self.currentCities.sort { (City1: City, City2: City) -> Bool in
            return City1.name < City2.name && City1.country < City2.country
        }
        self.citiesTable.reloadData()
    }
    
    
}
extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentCities.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath) as! CityTableViewCell
        let currentCity = currentCities[indexPath.row]
        cell.CityLabel.text = currentCity.name + ", " + currentCity.country
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCity = self.currentCities[indexPath.row]
        WeatherSettings.cityName = currentCity.name
        WeatherSettings.lon = currentCity.lon
        WeatherSettings.lat = currentCity.lat
        if let parent = self.presentingViewController as? ViewController{
            parent.setData()
        }
        self.dismiss(animated: true)
        
    }
    
    
}
