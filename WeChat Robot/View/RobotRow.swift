//
//  RobotRow.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct RobotCell : View, Identifiable {
  var title: String = "🤖️"
  let api: URL
  var id: String {
    return api.absoluteString
  }
  
    var body: some View {
      VStack(alignment: .leading) {
        Text(title).font(.title).color(.primary)
        Text(api.absoluteString).font(.footnote).color(.secondary)
      }
    }
}

#if DEBUG
struct RobotRow_Previews : PreviewProvider {
    static var previews: some View {
      RobotCell(title: "测试 🤖️", api: URL(string: "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb617")!)
    }
}
#endif
