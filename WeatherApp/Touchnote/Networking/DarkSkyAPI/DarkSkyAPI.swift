//
//  DarkSkyAPI.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation
import CoreLocation

class DarkSkyAPI {
    
    private static let baseURL = "https://api.forecast.io"
    private static let apiKey = "2b90f0f2f1cff873a68901768d74607e"
    
    private let networkService = NetworkService(baseURL: DarkSkyAPI.baseURL)
    private let parser = DarkSkyParser()
    
    func weather(location: CLLocation, completion: (Result<Weather>) -> ()) {
        self.networkService.request(ForecastAPIRequest(apiKey:DarkSkyAPI.apiKey, location: location)) { result in
            switch result {
            case .Success(let json):
                let weather = self.parser.parseCurrentWeather(json)
                if let weather = weather {
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(.Success(weather))
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(.Failure(.ParsingFailed))
                    })
                }
            case .Failure(let error):
                dispatch_async(dispatch_get_main_queue(), {
                    completion(.Failure(error))
                })
            }
        }
    }
}