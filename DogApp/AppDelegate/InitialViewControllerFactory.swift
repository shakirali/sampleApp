//
//  InitialViewControllerFactory.swift
//  DogApp
//
//  Created by Shakir Ali on 22/04/2019.
//  Copyright © 2019 Shakir Ali. All rights reserved.
//

import UIKit

final class InitialViewControllerFactory {
  
  private let storyboard: UIStoryboard
  
  init(storyboard: UIStoryboard) {
    self.storyboard = storyboard
  }
  
  public func viewController(withDataProvider dataProvider: DogDataProviding,
                             localizedDataProvider: LocalizedDataProviding) -> UIViewController? {
    
    let viewController = storyboard.instantiateInitialViewController()
    
    if let vc = viewController as? ViewControllerConfigurable {
    
      vc.configure(withDataProvider: dataProvider,
                               localizedDataProvider: localizedDataProvider)
    }
      
    return viewController
  }
}
