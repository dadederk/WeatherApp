//
//  Weather.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation

enum Icon: String, RawRepresentable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain, snow, sleet, wind, fog, cloudy
}

struct Weather {

    var temperature: Float
    var humidity: Float
    var rainProbability: Float
    var icon: Icon
}