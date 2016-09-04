//
//  ForecastAPIRequest.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation
import CoreLocation

enum Units: String, RawRepresentable {
    case si, us, ca, uk2, auto
}

struct ForecastAPIRequest: APIRequest {
    
    var location: CLLocation!
    var apiKey: String!
    
    var endpoint: String {
        return "forecast/\(self.apiKey)/\(self.location.coordinate.latitude),\(self.location.coordinate.longitude)"
    }
    
    var method: Method {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {
        return ["units": Units.si.rawValue]
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    init(apiKey: String, location: CLLocation) {
        self.apiKey = apiKey
        self.location = location
    }
}