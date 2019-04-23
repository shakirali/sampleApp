//
//  URLFactory.swift
//  DogApp
//
//  Created by Shakir Ali on 13/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

struct UrlFactory {
  
  static var search: URL { return URL(string: "https://api.thedogapi.com/v1/images/search")! }
  static var vote: URL { return URL(string: "https://api.thedogapi.com/v1/votes")!}
}

