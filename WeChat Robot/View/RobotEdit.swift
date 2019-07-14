//
//  RobotEdit.swift
//  WeChat Robot
//
//  Created by yk on 7/8/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct RobotEdit : View {
  var robot: Robot
  @State var textContent = ""
  @State var newsTitle = ""
  @State var newsDescription = ""
  @State var newsLink = ""
  @State var newsFigure = ""
  @State var selected: String = Robot.msgTypes[0]
  
  var body: some View {
    VStack(alignment: .leading) {
      SegmentedControl(selection: $selected) {
        ForEach(Robot.msgTypes.identified(by: \.self)) { type in
          Text(type.capitalized)
        }
      }
      .frame(height: 100)
      
      if selected == Robot.msgTypes[0] || selected == Robot.msgTypes[1] {
        Form {
          HStack {
            Text("内容").bold()
            Divider()
          MultilineTextView(
            self.$textContent
          )
            .frame(height: 150)
            .font(.body)
            
          }
        }
      } else {
        Form {
          HStack {
          Text("标题").bold().frame(width: 100)
            Divider()
            TextField("", text: self.$newsTitle)
          }
          HStack {
          Text("描述").bold().frame(width: 100)
            Divider()
            TextField("", text: self.$newsDescription)
          }
          HStack {
          Text("图片链接").bold().frame(width: 100)
            Divider()
            TextField("", text: self.$newsFigure)
          }
          HStack {
          Text("跳转链接").bold().frame(width: 100)
            Divider()
            TextField("", text: self.$newsLink)
          }
        }
      }
    }
  }
  
}

#if DEBUG
struct RobotEdit_Previews : PreviewProvider {
  static var previews: some View {
    RobotEdit(robot: Robot(title: "jl", url: "https://m.lagou.com/jobs/5642749.html"))
  }
}
#endif
