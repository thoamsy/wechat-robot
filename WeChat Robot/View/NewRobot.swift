//
//  NewRobot.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct NewRobot : View {
  @State var title: String = ""
  @State var url: String = ""
  
    var body: some View {
      NavigationView {
        List {
          Section {
            TextField("描述", text: $title)
          }
          Section {
            TextField("API URL", text: $url)
          }
        }.navigationBarTitle("New Robot")
          .listStyle(.grouped)
      }
    }
}

#if DEBUG
struct NewRobot_Previews : PreviewProvider {
    static var previews: some View {
        NewRobot()
    }
}
#endif
