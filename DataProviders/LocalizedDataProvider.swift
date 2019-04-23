//
//  LocalizedDataProvider.swift
//  DogApp
//
//  Created by Shakir Ali on 14/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

protocol LocalizedDataProviding {
  
  var voteSuccessMessage: String { get }
  var voteTitle: String { get }
  var voteAction: String { get }
  var breedGroupTitle: String { get }
  var temperamentTitle: String { get }
  var originTitle: String { get }
}

struct LocalizedDataProvider: LocalizedDataProviding {
  
  var voteSuccessMessage: String { return "Thank you. Your vote counted successfully." }
  var voteTitle: String { return "Vote" }
  var voteAction: String { return "OK" }
  var breedGroupTitle: String { return "Breed Group" }
  var temperamentTitle: String { return "Temperament" }
  var originTitle: String { return "Origin" }
}

extension LocalizedDataProvider: Equatable { }
