//
//  StubViewControllerConfigurable.swift
//  DogAppTests
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import UIKit
@testable import DogApp

final class StubViewControllerConfigurable: UIViewController, ViewControllerConfigurable {
  
  public private(set) var configureWasCalledWithDataProvider: DogDataProviding?
  public private(set) var configureWasCalledWithLocalizedDataProvider: LocalizedDataProviding?
  
  func configure(withDataProvider dataProvider: DogDataProviding, localizedDataProvider: LocalizedDataProviding) {
    
    configureWasCalledWithDataProvider = dataProvider
    configureWasCalledWithLocalizedDataProvider = localizedDataProvider
  }
  
  
  
}
