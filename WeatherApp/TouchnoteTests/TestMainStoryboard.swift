//
//  TestStoryboard.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import XCTest
@testable import Touchnote

class TestMainStoryboard: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialViewController_IsPopularItemsViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first
        
        XCTAssertTrue(rootViewController is CitiesWeatherViewController)
    }
    
}
