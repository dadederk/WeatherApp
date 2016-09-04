//
//  CityWeatherCellView.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation
import UIKit

class CityWeatherViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    
    func configure(city: String, weather: Weather?) {
        self.cityNameLabel.text = city
        
        if let weather = weather {
            self.weatherInfoLabel.text = self.weatherDescription(weather)
            self.weatherIconImage.image = UIImage(named: weather.icon.rawValue)
        }
    }
    
    func weatherDescription(weather: Weather) -> (String) {
        
        let temperature = "\(Int(weather.temperature))oC"
        let humidity = "\(Int(weather.humidity * 100))% humidity"
        let rainProbability = "\(Int(weather.rainProbability * 100))% chance of rain"
        
        return "\(temperature), \(humidity), \(rainProbability)"
    }
}