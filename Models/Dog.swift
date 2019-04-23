//
//  Dog.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

struct Dog: Codable {
  let id: String
  let url: String
  let breeds: [Breed]?
}

extension Dog: Equatable {
  
  static func == (lhs: Dog, rhs: Dog) -> Bool {
    return (lhs.id == rhs.id && lhs.url == rhs.url && lhs.breeds == rhs.breeds)
  }
}
