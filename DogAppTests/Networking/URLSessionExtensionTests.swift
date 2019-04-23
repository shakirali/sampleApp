//
//  URLSessionExtensionTests.swift
//  DogAppTests
//
//  Created by Shakir Ali on 14/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

class URLSessionExtensionTests: XCTestCase {
  
  var urlSession: StubURLSession?
  
  override func setUp() {
    
    super.setUp()
    urlSession = StubURLSession()
  }
  
  override func tearDown() {

    urlSession = nil
    super.tearDown()
  }
  
  func test_load_resourceIsCorrectlyReturned() {
    
    let expectedDog = Dog(id: "123", url: "www.test.com", breeds: [makeBreed()])
    
    let resource = Resource<Dog>(get: URL(string: "www.test.com")!)
    urlSession?.stubDataTask = StubURLSessionDataTask()
    let data = try! JSONEncoder().encode(expectedDog)
    urlSession?.stubData = data
    
    urlSession?.load(resource: resource) { result in
      switch(result) {
      case .success(let dog):
        XCTAssertEqual(dog, expectedDog)
      case .failure:
        XCTFail()
      }
    }
  }
}

private extension URLSessionExtensionTests {
  
  private func makeBreed() -> Breed {
    
    let weight = Weight(imperial: "20.0", metric: "5.0")
    let height = Height(imperial: "10.0", metric: "2.0")
    
    let breed = Breed(name: "Test", bred_for: "test", breed_group: "test", lifeSpan: "12", temperament: "Calm", origin: "UK", wikipedia_url: "www.test.com", weight: weight, height: height)
    
    return breed
  }
}

