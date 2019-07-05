//
//  RobotCell.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//


import SwiftUI

struct RobotCell : View {
  var robot: Robot
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(robot.title).font(.title).color(.primary)
      Text(robot.api.absoluteString).font(.footnote).color(.secondary)
    }
  }
}

#if DEBUG
struct RobotCell_Previews : PreviewProvider {
  static var previews: some View {
    RobotCell(robot: Robot(api: URL(string: "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb617")!))
  }
}
#endif
