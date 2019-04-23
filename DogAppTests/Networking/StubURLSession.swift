//
//  StubURLSession.swift
//  DogAppTests
//
//  Created by Shakir Ali on 14/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

final class StubURLSession: URLSession {
  
  var stubData: Data?
  var stubURLResponse: URLResponse?
  var error: Error?
  var stubDataTask: URLSessionDataTask?
  
  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    
    completionHandler(stubData, stubURLResponse, error)
    return stubDataTask!
  }
  
}
