//
//  StubDogDataProvider.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import UIKit
@testable import DogApp

final class StubDogDataProvider: DogDataProviding {
  
  private(set) var randomDogWasCalledWithCompletionBlock: Bool = false
  private(set) var imageWasCalledWithDog: Dog = Dog(id: "", url: "", breeds: nil)
  private(set) var voteWasCalledWithData: (up: Bool, imageId: String) = (false, "")
  var stubDogResult: Result<Dog, Error>?
  var stubImageResult: Result<UIImage, Error>?
  var stubVoteResult: Result<Votecast, Error>?
  
  func randomDog(completion: @escaping (Result<Dog, Error>) -> ()) {
    randomDogWasCalledWithCompletionBlock = true
    
    if let result = stubDogResult {
      completion(result)
    }
  }
  
  func image(for dog: Dog, completion: @escaping (Result<UIImage, Error>) -> ()) {
    
    imageWasCalledWithDog = dog
    
    if let result = stubImageResult {
      completion(result)
    }
  }
  
  func vote(up: Bool, for imageId: String, completion: @escaping (Result<Votecast, Error>) -> ()) {
    voteWasCalledWithData = (up: up, imageId: imageId)
    
    if let result = stubVoteResult {
      completion(result)
    }
  }
}
