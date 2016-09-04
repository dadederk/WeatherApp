//
//  APIRequest.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation

enum Method: String {
    case GET, POST, PUT
}

protocol APIRequest {
    var endpoint: String { get }
    var method: Method { get }
    var parameters: [String: AnyObject]? { get }
    var headers: [String: String]? { get }
}