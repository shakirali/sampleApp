//
//  InitialViewControllerFactory.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

class InitialViewControllerFactoryTests: XCTestCase {
  
  var factory: InitialViewControllerFactory!
  var stubVotingViewController: StubViewControllerConfigurable!
  
  override func setUp() {
    super.setUp()
    
    let stubStoryboard = StubStoryboard()
    stubVotingViewController = StubViewControllerConfigurable()
    stubStoryboard.stubViewControllerToReturn = stubVotingViewController
    factory = InitialViewControllerFactory(storyboard: stubStoryboard)
  }
  
  override func tearDown() {
    factory = nil
    
    super.tearDown()
  }
  
  func test_viewController_viewControllerIsConfiguredCorrectly() {
    
    let dataProvider = DogDataProvider()
    let localizedDataProvider = LocalizedDataProvider()
    
    _ = factory.viewController(withDataProvider: dataProvider,
                           localizedDataProvider: localizedDataProvider)
    
    XCTAssertEqual(stubVotingViewController.configureWasCalledWithDataProvider as! DogDataProvider, dataProvider)
    XCTAssertEqual(stubVotingViewController.configureWasCalledWithLocalizedDataProvider as! LocalizedDataProvider, localizedDataProvider)
  }
}
