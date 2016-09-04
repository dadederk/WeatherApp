//
//  TestCityWeatherCellView.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import XCTest
@testable import Touchnote

class TestCityWeatherCellView: XCTestCase {
    
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller = storyboard.instantiateViewControllerWithIdentifier(String(CitiesWeatherViewController)) as! CitiesWeatherViewController
        
        _ = controller.view
        
        self.tableView = controller.tableView
        self.tableView.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        
        let dataSource = FakeDataSource()
        
        self.tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
    
    override func tearDown() {
        self.tableView = nil
        super.tearDown()
    }
    
    func testCellHasCityNameAndWeatherInfoLabels() {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(String(CityWeatherViewCell),
                                                                    forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! CityWeatherViewCell
        
        XCTAssertNotNil(cell.cityNameLabel, "Cell should have a city name label")
        XCTAssertNotNil(cell.weatherInfoLabel, "Cell should have a weather info label")
    }
    
    func testConfigureCellSetsCityNameLabel() {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(String(CityWeatherViewCell),
                                                                    forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! CityWeatherViewCell
        let expectedCityName = "London"
        cell.configure(expectedCityName, weather: nil)
        
        XCTAssertEqual(cell.cityNameLabel.text, expectedCityName, "Incorrect city name")
    }
    
    func testConfigureCellSetsWeatherInfoLabel() {
    
        let cell = self.tableView.dequeueReusableCellWithIdentifier(String(CityWeatherViewCell),
                                                                    forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! CityWeatherViewCell
        let expectedCityName = "London"
        let weather = Weather(temperature: 28, humidity: 56, rainProbability: 0, icon: .clearDay)
        cell.configure(expectedCityName, weather: weather)
        
        let temperature = "\(Int(weather.temperature))oC"
        let humidity = "\(Int(weather.humidity * 100))% humidity"
        let rainProbability = "\(Int(weather.rainProbability * 100))% chance of rain"
        
        let expectedWeatherInfo =  "\(temperature), \(humidity), \(rainProbability)"
        
        XCTAssertEqual(cell.weatherInfoLabel.text, expectedWeatherInfo, "Incorrect formatting of the weather info")
    }
}

class FakeDataSource: NSObject, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}