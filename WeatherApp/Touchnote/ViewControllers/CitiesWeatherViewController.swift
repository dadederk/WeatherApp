//
//  ViewController.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import UIKit
import CoreLocation

struct CityWeather {
    let cityName: String
    let location: CLLocation
}

class CitiesWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let darkSkyAPI = DarkSkyAPI()
    
    // TODO: Move the initial cities to a plist file
    var citiesWeather = CitiesWeather(cities: ["London", "Paris", "New York", "Los Angeles", "Tokyo", "Xàbia"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        self.tableView.dataSource = self
        
        self.getLocationOfTheCities { [weak self] (cityName, location) in
            self?.citiesWeather[cityName] = (cityName, location, nil)
            self?.getWeather(location, completion: { [weak self] (weather) in
                self?.citiesWeather[cityName] = (cityName, location, weather)
                self?.tableView.reloadData()
                })
        }
    }
    
    // TODO: Persist location
    
    /* The API gets as part of the url the latitude and longitude of the location for getting the weather conditions.
     I've decided to get the location of each city using a CLGeoCoder, implemented in the class LocationManager */
    func getLocationOfTheCities(completion: (cityName: String, location: CLLocation) -> ()) {
        for cityWeather in citiesWeather.citiesWithLocationAndWeather {
            let cityName = cityWeather.cityName
            LocationManager.location(cityName, completion: { (location, error) in
                if let error = error {
                    print("Error getting location for city \(cityName): \(error)")
                } else if let location = location {
                    completion(cityName: cityName, location: location)
                }
            })
        }
    }
    
    func getWeather(location: CLLocation, completion: (weather: Weather) -> ()) {
        self.darkSkyAPI.weather(location, completion: { result in
            switch result {
            case .Success(let weather):
                completion(weather: weather)
            case .Failure(let error):
                print(error)
            }
        })
    }
}

// TODO: Implement generic table view data source

extension CitiesWeatherViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citiesWeather.citiesWithLocationAndWeather.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CityWeatherViewCell)) as? CityWeatherViewCell
        let cityWeather = self.citiesWeather.citiesWithLocationAndWeather[indexPath.row]
        cell?.configure(cityWeather.cityName, weather: cityWeather.weather)
        return cell!
    }
    
}