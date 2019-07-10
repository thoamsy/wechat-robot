//
//  RobotStore.swift
//  WeChat Robot
//
//  Created by yk on 7/10/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI
import Combine

final class RobotStore: BindableObject {
  let didChange = PassthroughSubject<RobotStore, Never>()
  
  var robots: [Robot] = [] {
    didSet {
      print(oldValue)
      didChange.send(self)
    }
  }
  
  init(robots: [Robot] = []) {
    self.robots = robots
  }
}
