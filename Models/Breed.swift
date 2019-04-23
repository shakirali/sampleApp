//
//  Breed.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

struct Weight: Codable {
  let imperial: String?
  let metric: String?
}

extension Weight: Equatable {

  static func == (lhs: Weight, rhs: Weight) -> Bool {
    return (lhs.imperial == rhs.imperial &&
            lhs.metric == rhs.metric)
  }
  
}

struct Height: Codable {
  let imperial: String?
  let metric: String?
}

extension Height: Equatable {
  
  static func == (lhs: Height, rhs: Height) -> Bool {
    return (lhs.imperial == rhs.imperial &&
            lhs.metric == rhs.metric)
  }
}

struct Breed: Codable {
  let name: String?
  let bred_for: String?
  let breed_group: String?
  let lifeSpan: String?
  let temperament: String?
  let origin: String?
  let wikipedia_url: String?
  let weight: Weight?
  let height: Height?
}

extension Breed: Equatable {
  static func == (lhs: Breed, rhs: Breed) -> Bool {
    return (lhs.name == rhs.name &&
            lhs.bred_for == rhs.bred_for &&
            lhs.breed_group == rhs.breed_group &&
            lhs.lifeSpan == rhs.lifeSpan &&
            lhs.temperament == rhs.temperament &&
            lhs.origin == rhs.origin &&
            lhs.wikipedia_url == rhs.wikipedia_url &&
            lhs.weight == rhs.weight &&
            lhs.height == rhs.height )
  }
}

