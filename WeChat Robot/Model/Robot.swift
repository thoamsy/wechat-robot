//
//  Robot.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI
import Combine

final class Robot: Identifiable & BindableObject {
  
  var didChange = PassthroughSubject<Robot, Never>()
  
  
  init?(title: String = "🤖️", url api: String) {
    self.title = title
    guard let vaildURL = URL(string: api) else { return nil }
    self.api = vaildURL
  }
  
  var title = "🤖️" {
    didSet {
      didChange.send(self)
    }
  }
  var api: URL {
    didSet {
      didChange.send(self)
    }
  }
  var id: String {
    api.absoluteString
  }
}
