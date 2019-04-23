//
//  Resource.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

enum HttpMethod<Body> {
  case get
  case post(Body)
}

extension HttpMethod {
  var method: String {
    switch self {
    case .get:
      return "GET"
    case .post:
      return "POST"
    }
  }
}

struct Resource<A> {
  var urlRequest: URLRequest
  let parse: (Data) -> A?
}

extension Resource where A: Decodable {
  
  init(get url: URL) {
    self.urlRequest = URLRequest(url: url)
    self.parse = { data in
      try? JSONDecoder().decode(A.self, from: data)
    }
    urlRequest.configureAPIKey()
  }
  
  init<Body: Encodable>(url: URL, method: HttpMethod<Body>) {
    urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.method
    switch method {
    case .get: ()
    case .post(let body):
      self.urlRequest.httpBody = try! JSONEncoder().encode(body)
    }
    self.parse = { data in
      try? JSONDecoder().decode(A.self, from: data)
    }
    urlRequest.configureAPIKey()
  }
}
