//
//  URLSessionExtension.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation
import UIKit

struct URLRequestHeader {
  static let apiKeyTitle = "x-api-key"
  static let apiKeyValue = "f3fe57d6-112c-4161-bfa5-d2e6d1532772"
  static let contentTypeTitle = "Content-Type"
  static let contentTypeValue = "application/json"
}

extension URLRequest {
  
  mutating func configureAPIKey() {
    self.setValue(URLRequestHeader.apiKeyValue, forHTTPHeaderField: URLRequestHeader.apiKeyTitle)
    self.setValue(URLRequestHeader.contentTypeValue, forHTTPHeaderField: URLRequestHeader.contentTypeTitle)
    
  }
}

protocol ResourceDownloadable {
  func load<A>(resource: Resource<A>, completion: @escaping (Result<A, Error>) -> ())
  
  func downloadImage(urlRequest: URLRequest, completion: @escaping(Result<UIImage, Error>) -> ())
}

extension URLSession: ResourceDownloadable {
  
  func load<A>(resource: Resource<A>, completion: @escaping (Result<A, Error>) -> ()) {
    
    dataTask(with: resource.urlRequest) { (data, response, error) in
      
      if let error = error {
        let result = Result<A, Error>.failure(error)
        completion(result)
      } else {
        if let value = data.flatMap(resource.parse) {
          let result = Result<A, Error>.success(value)
          completion(result)
        }
      }
    }.resume()
  }
  
  func downloadImage(urlRequest: URLRequest, completion: @escaping(Result<UIImage, Error>) -> ()) {
    
    dataTask(with: urlRequest) { (data, response, error) in
      
      if let error = error {
        let result = Result<UIImage, Error>.failure(error)
        completion(result)
      } else {
        if
          let data = data,
          let image = UIImage(data: data) {
            let result = Result<UIImage, Error>.success(image)
            completion(result)
        }
      }
      }.resume()
    }
}
