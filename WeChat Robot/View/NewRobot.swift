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
  @State var hasError = false
  @State var canSave = false
  
    var body: some View {
      NavigationView {
        Form {
          Section {
            TextField("描述", text: $title)
          }
          Section {
            VStack(alignment: .leading) {
            TextField("API URL", text: $url, onCommit: {
              if let url = URL(string: self.url),  !self.title.isEmpty {
                self.canSave = true
                self.hasError = false
              } else {
                print("fuck you")
                self.hasError = true
                self.canSave = false
              }
            }).textContentType(.URL)
            hasError ? Text("你必须输入合法的 URL").color(.red) : nil
          }
          }
        }
        .navigationBarTitle("New Robot")
          .navigationBarItems(trailing: Button(action: {}) { Text("Save") }.disabled(!canSave))
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
