//
//  VotingViewModelTests.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest
@testable import DogApp

class VotingViewModelTests: XCTestCase {
  
  private var viewModel: VotingViewModel!
  
  override func setUp() {
    super.setUp()
    
    viewModel = VotingViewModel(localizedProvider: LocalizedDataProvider())
  }
  
  override func tearDown() {
    viewModel = nil
    super.tearDown()
  }
  
  func test_viewModel() {
    
    let breed = makeBreed()
    let dog = Dog(id: "12", url: "www.dog.com", breeds: [breed])
    viewModel.setup(with: dog)
    
    XCTAssertEqual(viewModel.breedGroup, breed.breed_group)
    XCTAssertEqual(viewModel.name, breed.name)
    XCTAssertEqual(viewModel.origin, breed.origin)
    XCTAssertEqual(viewModel.temperament, breed.temperament)
  }
  
}

private extension VotingViewModelTests {

  func makeBreed() -> Breed {
    let breed = Breed(name: "test_breed", bred_for: nil, breed_group: "breed_group", lifeSpan: nil, temperament: "Calm", origin: "UK", wikipedia_url: nil, weight: nil, height: nil)
    
    return breed
  }
}
