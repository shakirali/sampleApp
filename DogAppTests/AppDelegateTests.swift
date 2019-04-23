//
//  AppDelegateTests.swift
//  DogAppTests
//
//  Created by Shakir Ali on 23/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

class AppDelegateTests: XCTestCase {
  
  var appDelegate: AppDelegate!
  
  override func setUp() {
    
    super.setUp()
    
    appDelegate = AppDelegate()
  }
  
  override func tearDown() {
    
    appDelegate = nil
    super.tearDown()
  }
  
  func testExample() {
    
    let value = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    
    guard value else {
      XCTFail()
      return
    }
    
    XCTAssertNotNil(appDelegate.window?.rootViewController as? VotingViewController)
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
