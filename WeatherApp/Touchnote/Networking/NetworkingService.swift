//
//  NetworkingService.swift
//  Touchnote
//
//  Created by Daniel Devesa Derksen-Staats on 04/09/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(Error)
}

enum Error: ErrorType {
    case InvalidURL
    case RequestFailed
    case JSONSerializationFailed
    case ParsingFailed
}

class NetworkService {
    private var task: NSURLSessionTask?
    
    let baseURL: String
    let timeoutInterval = 10.0
    let session = NSURLSession.sharedSession()
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func request(request: APIRequest, completion:(Result<AnyObject>) -> ()) {
        let URL = NSURL(string: self.baseURL)?.URLByAppendingPathComponent(request.endpoint)
        
        if let URL = URL {
            let request = self.buildRequestWithURL(URL, request: request)
            
            self.task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                if let _ = error {
                    completion(.Failure(.RequestFailed))
                } else if let data = data {
                    do {
                        let responseData = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                        completion(.Success(responseData))
                    } catch {
                        completion(.Failure(.JSONSerializationFailed))
                    }
                }
            })
            
            self.task?.resume()
        } else {
            completion(.Failure(.InvalidURL))
        }
    }
    
    func cancel() {
        if let task = self.task {
            task.cancel()
        }
    }
    
    private func buildRequestWithURL(URL: NSURL, request: APIRequest) -> NSURLRequest {
        let mutableRequest = NSMutableURLRequest(URL: URL, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: self.timeoutInterval)
        mutableRequest.allHTTPHeaderFields = request.headers
        mutableRequest.HTTPMethod = request.method.rawValue
        
        if let parameters = request.parameters,
            let URLWithParameters = self.URLByAppending(parameters, URL: URL) {
            mutableRequest.URL = URLWithParameters
        }
        
        return mutableRequest
    }
    
    private func URLByAppending(parameters: [String: AnyObject], URL: NSURL) -> NSURL? {
        let urlComponents = NSURLComponents(URL: URL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            if let value = value as? String {
                urlComponents?.queryItems?.append(NSURLQueryItem(name: key, value: value))
            }
        }
        return urlComponents?.URL
    }
}