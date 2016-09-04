//
//  DarkSkyParser.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation

class DarkSkyParser {
    
    func parseCurrentWeather(json: AnyObject) -> Weather? {
        var weather: Weather?
        
        if let currentWeather = json.objectForKey("currently") as? [String: AnyObject] {
            weather = self.parseWeather(currentWeather)
        }
        
        return weather
    }
    
    // TODO: Remove forced unwrapping! from Icon
    
    func parseWeather(json: AnyObject) -> Weather? {
        var weather: Weather?
        
        if let temperature = json.objectForKey("temperature") as? Float,
            let humidity = json.objectForKey("humidity") as? Float,
            let rainProbability = json.objectForKey("precipProbability") as? Float,
            let icon = json.objectForKey("icon") as? String {
            weather = Weather(temperature:temperature,
                                humidity: humidity,
                                rainProbability: rainProbability,
                                icon: Icon(rawValue: icon)!)
        }
        
        return weather
    }
}