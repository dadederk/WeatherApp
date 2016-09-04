//
//  File.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation
import CoreLocation

// TODO: Implement SequenceType protocol instead of public citiesWithLocationAndWeather array

struct CitiesWeather {

    typealias CityWithLocationAndWeather = (cityName: String, location: CLLocation?, weather: Weather?)
    
    var citiesWithLocationAndWeather = [CityWithLocationAndWeather]()
    
    init(cities: [String]) {
        self.loadCities(cities)
    }
    
    private mutating func loadCities(cities: [String]) {
        for city in cities {
            self.citiesWithLocationAndWeather.append((city, nil, nil))
        }
    }
    
    private func indexForCity(city: String) -> Int? {
        var cityIndex: Int?
        for (index, cityWithLocationAndWeather) in self.citiesWithLocationAndWeather.enumerate() {
            if cityWithLocationAndWeather.cityName == city {
                cityIndex = index
            }
        }
        return cityIndex
    }
    
    subscript(key: String) -> CityWithLocationAndWeather? {
        get {
            if let index = self.indexForCity(key) {
                return self.citiesWithLocationAndWeather[index]
            } else {
                return nil
            }
        }
        
        set {
            if let index = self.indexForCity(key) {
                var cityLocationAndWeather = self.citiesWithLocationAndWeather[index]
                
                if let cityName = newValue?.cityName {
                    cityLocationAndWeather.cityName = cityName
                }
                if let location = newValue?.location {
                    cityLocationAndWeather.location = location
                }
                if let weather = newValue?.weather {
                    cityLocationAndWeather.weather = weather
                }
                
                self.citiesWithLocationAndWeather[index] = cityLocationAndWeather
            }
        }
    }
}