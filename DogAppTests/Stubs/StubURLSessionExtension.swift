//
//  StubURLSession.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import UIKit
@testable import DogApp

final class StubURLSessionExtension<A>: ResourceDownloadable {
  
  var stubResourceResultToReturn: Result<A, Error>!
  var stubImageResultToReturn: Result<UIImage, Error>!
  
  func load<A>(resource: Resource<A>, completion: @escaping (Result<A, Error>) -> ()) {
    
    completion(stubResourceResultToReturn as! Result<A, Error>)
  }
  
  
  func downloadImage(urlRequest: URLRequest, completion: @escaping(Result<UIImage, Error>) -> ()) {
    
    completion(stubImageResultToReturn)
  }
  
}
