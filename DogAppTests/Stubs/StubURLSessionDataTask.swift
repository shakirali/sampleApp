//
//  StubURLSessionDataTask.swift
//  DogAppTests
//
//  Created by Shakir Ali on 14/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import Foundation

final class StubURLSessionDataTask: URLSessionDataTask {
  
  public private(set) var resumeWasCalled: Bool = false
  
  override func resume() {
    
    resumeWasCalled = true
  }
}
