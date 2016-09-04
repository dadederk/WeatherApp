//
//  TestWeather.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import XCTest
@testable import Touchnote

class TestWeather: XCTestCase {
    
    var weather: Weather!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.weather = nil
        super.tearDown()
    }
    
    func testInitShouldSetTemperatureHumidityRainProbabilityAndIcon() {
        let expectedTemperature: Float = 28.0
        let expectedHumidity: Float = 0.56
        let expectedRainProbability: Float = 0.1
        let expectedIcon = Icon.clearDay
        self.weather = Weather(temperature: expectedTemperature, humidity: expectedHumidity, rainProbability: expectedRainProbability, icon: expectedIcon)
        
        XCTAssertEqual(self.weather.temperature, expectedTemperature, "Temperature not set correctly")
        XCTAssertEqual(self.weather.humidity, expectedHumidity, "Humidity not set correctly")
        XCTAssertEqual(self.weather.rainProbability, expectedRainProbability, "Rain probability not set correctly")
        XCTAssertEqual(self.weather.icon, expectedIcon, "Icon not set correctly")
    }
}