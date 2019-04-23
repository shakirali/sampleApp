//
//  StubStoryboard.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import XCTest

final class StubStoryboard: UIStoryboard {
  
  var stubViewControllerToReturn: UIViewController?
  
  override func instantiateInitialViewController() -> UIViewController? {
    
    return stubViewControllerToReturn
  }
  
}
