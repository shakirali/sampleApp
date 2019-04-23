//
//  DogDataProviderTests.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

private final class TestError: Error { }

class DogDataProviderTests: XCTestCase {
  
  private var dataProvider: DogDataProvider!
  private var stubSession: StubURLSessionExtension<[Dog]>!
  
  override func setUp() {
    
    super.setUp()
    
    stubSession = StubURLSessionExtension()
    dataProvider = DogDataProvider(session: stubSession)
  }
  
  override func tearDown() {
    
    stubSession = nil
    dataProvider = nil
    
    super.tearDown()
  }
  
  func test_randomDog_successResult_returnsExpectedValue() {
    

    let breeds: [Breed] = [makeBreed()]
    let expectedDog = Dog(id: "1", url: "www.test.com", breeds: breeds)
    stubSession.stubResourceResultToReturn = Result<[Dog], Error>.success([expectedDog])
    
    let testExpectation = XCTestExpectation(description: "test")
    
    let expectedCompletion: (Result<Dog, Error>) -> ()  = { result in
      
      switch result {
      case .success(let dog):
        XCTAssertEqual(dog, expectedDog)
      default:
        XCTFail()
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.randomDog(completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
  }
  
  func test_randomDog_errorResult_returnsExpectedValue() {
    
    stubSession.stubResourceResultToReturn = Result<[Dog], Error>.failure(TestError())
    
    let testExpectation = XCTestExpectation(description: "test")
    
    let expectedCompletion: (Result<Dog, Error>) -> ()  = { result in
      
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error as? TestError)
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.randomDog(completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
  }
  
  func test_image_successResult_returnsExpectedValue() {
    
    let dog = Dog(id: "1", url: "www.test.com", breeds: nil)
    let expectedImage = UIImage()
    
    let testExpectation = XCTestExpectation(description: "test")
    
    stubSession.stubImageResultToReturn = Result<UIImage, Error>.success(expectedImage)
    
    let expectedCompletion: (Result<UIImage, Error>) -> ()  = { result in
      
      switch result {
      case .success(let image):
        XCTAssertEqual(image, expectedImage)
      default:
        XCTFail()
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.image(for: dog, completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
    
  }
  
  func test_image_errorResult_returnsExpectedValue() {
    
    stubSession.stubImageResultToReturn = Result<UIImage, Error>.failure(TestError())
    
    let testExpectation = XCTestExpectation(description: "test")
    let dog = Dog(id: "1", url: "www.test.com", breeds: nil)
    
    let expectedCompletion: (Result<UIImage, Error>) -> ()  = { result in
      
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error as? TestError)
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.image(for: dog, completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
  }
  
  func test_vote_upIsTrue_SuccessResult_returnExpectedValue() {
    
    let urlSessionExtension = StubURLSessionExtension<Votecast>()
    dataProvider = DogDataProvider(session: urlSessionExtension)
    
    let expectedVotecast = Votecast(message: "vote cast", id: 1)
    urlSessionExtension.stubResourceResultToReturn = Result<Votecast, Error>.success(expectedVotecast)
    
    let testExpectation = XCTestExpectation(description: "test")
    
    let expectedCompletion: (Result<Votecast, Error>) -> ()  = { result in
      
      switch result {
      case .success(let votecast):
        XCTAssertEqual(votecast, expectedVotecast)
      default:
        XCTFail()
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.vote(up: true, for: "1", completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
  }
  
  func test_vote_upIsFalse_successResult_returnExpectedValue() {
    
    let urlSessionExtension = StubURLSessionExtension<Votecast>()
    dataProvider = DogDataProvider(session: urlSessionExtension)
    
    let expectedVotecast = Votecast(message: "vote cast", id: 1)
    urlSessionExtension.stubResourceResultToReturn = Result<Votecast, Error>.success(expectedVotecast)
    
    let testExpectation = XCTestExpectation(description: "Should return success")
    
    let expectedCompletion: (Result<Votecast, Error>) -> ()  = { result in
      
      switch result {
      case .success(let votecast):
        XCTAssertEqual(votecast, expectedVotecast)
      default:
        XCTFail()
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.vote(up: false, for: "1", completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
  }

  func test_vote_upIsTrue_errorResult_returnExpectedValue() {
    
    let urlSessionExtension = StubURLSessionExtension<Votecast>()
    dataProvider = DogDataProvider(session: urlSessionExtension)
    
    urlSessionExtension.stubResourceResultToReturn = Result<Votecast, Error>.failure(TestError())
    
    let testExpectation = XCTestExpectation(description: "Should return error")
    
    let expectedCompletion: (Result<Votecast, Error>) -> ()  = { result in
      
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error as? TestError)
      }
      
      testExpectation.fulfill()
    }
    
    dataProvider.vote(up: false, for: "1", completion: expectedCompletion)
    
    wait(for: [testExpectation], timeout: 3.0)
  }
}

private extension DogDataProviderTests {
  
  private func makeBreed() -> Breed {
    
    let weight = Weight(imperial: "20.0", metric: "5.0")
    let height = Height(imperial: "10.0", metric: "2.0")
    
    let breed = Breed(name: "Test", bred_for: "test", breed_group: "test", lifeSpan: "12", temperament: "Calm", origin: "UK", wikipedia_url: "www.test.com", weight: weight, height: height)
    
    return breed
  }
}
