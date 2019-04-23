//
//  VoteCast.swift
//  DogApp
//
//  Created by Shakir Ali on 14/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

struct Votecast: Codable {
  let message: String
  let id: Int
}

extension Votecast: Equatable {
  
  static func == (lhs: Votecast, rhs: Votecast) -> Bool {
    return (lhs.message == rhs.message &&
            lhs.id == rhs.id)
  }
}
