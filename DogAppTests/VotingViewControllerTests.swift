//
//  VotingViewControllerTests.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

private final class TestError: Error { }

final class VotingViewControllerTests: XCTestCase {
  
  private var viewController: VotingViewController!
  private var stubDataProvider: StubDogDataProvider!
  
  override func setUp() {
    
    super.setUp()
    
    stubDataProvider = StubDogDataProvider()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = storyboard.instantiateInitialViewController() as? VotingViewController
    viewController.configure(withDataProvider: stubDataProvider, localizedDataProvider: LocalizedDataProvider())
  }
  
  override func tearDown() {
    
    viewController = nil
    super.tearDown()
  }
  
  func test_viewDidLoad_dataProviderRandomDogIsCalled() {
    viewController.loadViewIfNeeded()
    
    viewController.viewDidLoad()
    XCTAssertTrue(stubDataProvider.randomDogWasCalledWithCompletionBlock)
  }
  
  func test_viewDidLoad_dataProviderRandomDogReturnsWithSuccessAndImageDownloadIsCalled() {
    
    let dog = Dog(id: "1", url: "www.test.com", breeds: nil)
    stubDataProvider.stubDogResult = Result<Dog, Error>.success(dog)
    
    viewController.loadViewIfNeeded()
    
    viewController.viewDidLoad()
    XCTAssertTrue(stubDataProvider.randomDogWasCalledWithCompletionBlock)
    XCTAssertEqual(stubDataProvider.imageWasCalledWithDog, dog)
  }
  
  func test_viewDidLoad_dataProviderRandomDogReturnsWithErrorAndImageDownloadIsNotCalled() {
    
    stubDataProvider.stubDogResult = Result<Dog, Error>.failure(TestError())
    
    viewController.loadViewIfNeeded()
    
    viewController.viewDidLoad()
    XCTAssertTrue(stubDataProvider.randomDogWasCalledWithCompletionBlock)
    XCTAssertEqual(stubDataProvider.imageWasCalledWithDog.id, "")
  }
  
  func test_nextBtnTapped_randomDogReturnsSuccessAndImageDownloadIsCalled() {
    
    let dog = Dog(id: "1", url: "www.test.com", breeds: nil)
    stubDataProvider.stubDogResult = Result<Dog, Error>.success(dog)
    
    viewController.loadViewIfNeeded()
    
    viewController.nextBtnTapped()
    
    XCTAssertTrue(stubDataProvider.randomDogWasCalledWithCompletionBlock)
    XCTAssertEqual(stubDataProvider.imageWasCalledWithDog, dog)
  }
  
  func test_nextBtnTapped_randomDogReturnsErrorAndImageDownloadIsNotCalled() {
    
    stubDataProvider.stubDogResult = Result<Dog, Error>.failure(TestError())
    
    viewController.loadViewIfNeeded()
    
    viewController.nextBtnTapped()
    
    XCTAssertTrue(stubDataProvider.randomDogWasCalledWithCompletionBlock)
    XCTAssertEqual(stubDataProvider.imageWasCalledWithDog.id, "")
  }
  
  func test_upVoteBtnTapped_voteUpIsSuccess_returnsExpectedValues() {
    
    let dog = Dog(id: "1", url: "www.test.com", breeds: nil)
    stubDataProvider.stubDogResult = Result<Dog, Error>.success(dog)
    
    let votecast = Votecast(message: "Vote up", id: 1)
    stubDataProvider.stubVoteResult = Result<Votecast, Error>.success(votecast)
    
    viewController.loadViewIfNeeded()
    
    viewController.upVoteBtnTapped()
    
    XCTAssertTrue(stubDataProvider.voteWasCalledWithData.up)
    XCTAssertEqual(stubDataProvider.voteWasCalledWithData.imageId, dog.id)
  }

  func test_upVoteBtnTapped_voteDownIsSuccess_returnsExpectedValues() {
    
    let dog = Dog(id: "1", url: "www.test.com", breeds: nil)
    stubDataProvider.stubDogResult = Result<Dog, Error>.success(dog)
    
    let votecast = Votecast(message: "Vote down", id: 1)
    stubDataProvider.stubVoteResult = Result<Votecast, Error>.success(votecast)
    
    viewController.loadViewIfNeeded()
    
    viewController.downVoteBtnTapped()
    
    XCTAssertFalse(stubDataProvider.voteWasCalledWithData.up)
    XCTAssertEqual(stubDataProvider.voteWasCalledWithData.imageId, dog.id)
  }
}
