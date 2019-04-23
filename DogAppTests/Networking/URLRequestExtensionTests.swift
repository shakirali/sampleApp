//
//  URLRequestTests.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

final class URLRequestTests: XCTestCase {
  
  var urlRequest: URLRequest!
  
  override func setUp() {
    super.setUp()
    
    let url = URL(string: "www.test.com")!
    urlRequest = URLRequest(url: url)
  }
  
  override func tearDown() {
    urlRequest = nil
    super.tearDown()
  }
  
  func test_configureAPIKey() {
    
    urlRequest.configureAPIKey()
    XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "x-api-key"), "f3fe57d6-112c-4161-bfa5-d2e6d1532772")
    XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
  }
  
}
