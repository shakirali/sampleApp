//
//  DogDataProvider.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation
import UIKit

protocol DogDataProviding {
  
  func randomDog(completion: @escaping (Result<Dog, Error>) -> ())
  func image(for dog: Dog, completion: @escaping (Result<UIImage, Error>) -> ())
  func vote(up: Bool, for imageId: String, completion: @escaping (Result<Votecast, Error>) -> ())
}

final class DogDataProvider: DogDataProviding {
  
  let session: ResourceDownloadable
  
  init(session: ResourceDownloadable = URLSession.shared) {
    self.session = session
  }
  
  func randomDog(completion: @escaping (Result<Dog, Error>) -> ()) {
    
    let resource = Resource<[Dog]>(get: UrlFactory.search)
    session.load(resource: resource) { result in
      switch result {
      case .success(let dogs):
        if let dog = dogs.first {
          DispatchQueue.main.async {
            completion(.success(dog))
          }
        }
      case .failure(let error):
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
  
  func image(for dog: Dog, completion: @escaping (Result<UIImage, Error>) -> ()) {
    
    if let url = URL(string: dog.url) {
      let urlRequest = URLRequest(url: url)
      session.downloadImage(urlRequest: urlRequest) { result in
          DispatchQueue.main.async {
            completion(result)
          }
      }
    }
  }
  
  func vote(up: Bool, for imageId: String, completion: @escaping (Result<Votecast, Error>) -> ()) {
    
    let value = up ? 1 : 0
    let vote = Vote(image_id: imageId, value: value)
    
    let resource = Resource<Votecast>(url: UrlFactory.vote, method: .post(vote))
    session.load(resource: resource) { result in
      switch result {
      case .success(let voteCast):
          DispatchQueue.main.async {
            completion(.success(voteCast))
          }
      case .failure(let error):
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
}

extension DogDataProvider: Equatable {
  static func == (lhs: DogDataProvider, rhs: DogDataProvider) -> Bool {
    
    guard
      let lhsSession = lhs.session as? URLSession,
    let rhsSession = rhs.session as? URLSession else { return false }
    return (lhsSession == rhsSession)
  }
}

