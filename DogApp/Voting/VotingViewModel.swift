//
//  VotingViewModel.swift
//  DogApp
//
//  Created by Shakir Ali on 14/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

struct VotingViewModel {
  
  var name: String?
  var breedGroup: String?
  var temperament: String?
  var origin: String?
  
  let breedGroupTitle: String
  let temperamentTitle: String
  let originTitle: String
  
  let localizedProvider: LocalizedDataProviding
  
  init(localizedProvider: LocalizedDataProviding) {
    self.localizedProvider = localizedProvider
    self.breedGroupTitle = localizedProvider.breedGroupTitle
    self.temperamentTitle = localizedProvider.temperamentTitle
    self.originTitle = localizedProvider.originTitle
  }
  
  mutating func setup(with dog: Dog) {
    
    guard let breed = dog.breeds?.first else { return }
    
    name = breed.name
    breedGroup = breed.breed_group
    temperament = breed.temperament
    origin = breed.origin
  }
  
}
