//
//  TestCitiesWeatherViewController.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import XCTest
@testable import Touchnote

class TestCitiesWeatherViewController: XCTestCase {
    
    var viewController: CitiesWeatherViewController!
    var citiesWeather: CitiesWeather!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController()
        self.viewController = navigationController?.childViewControllers.first as! CitiesWeatherViewController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = self.viewController
        
        XCTAssertNotNil(navigationController!.view)
        XCTAssertNotNil(self.viewController.view)
        
        self.citiesWeather = CitiesWeather(cities: ["London", "Paris", "New York", "Los Angeles", "Tokyo", "Xàbia"])
    }
    
    override func tearDown() {
        self.citiesWeather = nil
        super.tearDown()
    }
    

    // TODO: Implement tests for CitiesWeatherViewController
}

class FakeTableView: UITableView {
    
    var reloadDataCalled = false
    
    override func reloadData() {
        super.reloadData()
        reloadDataCalled = true
    }
}