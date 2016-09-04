//
//  LocationManager.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationManager {
    
    static func location(cityName: String, completion:(location: CLLocation?, error: NSError?) -> ()) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let error = error {
                completion(location: nil, error: error)
            } else {
                if let placemark = placemarks?.first {
                    completion(location: placemark.location, error: nil)
                }
            }
        }
    }
}