//
//  Robot.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct Robot: Identifiable {
  var title = "🤖️"
  let api: URL
  var id: String {
    api.absoluteString
  }
}
