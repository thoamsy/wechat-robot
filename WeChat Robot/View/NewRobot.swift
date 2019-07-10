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
  @State var urlString: String = ""
  @State var hasError = false
  @State var canSave = false
  
  private func isValidAPIKey(with url: String) -> Bool {
    guard
      let url = URL(string: self.urlString),
      !self.title.isEmpty,
      let item = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?[0],
      item.name == "key",
      let _ = item.value
      else {
        return false
    }
    return true
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("描述", text: $title)
        }
        Section {
          VStack(alignment: .leading) {
            TextField("API URL", text: $urlString, onCommit: {
              
              if (self.isValidAPIKey(with: self.urlString)) {
                self.hasError = false
                self.canSave = true
              } else {
                self.hasError = true
                self.canSave = false
              }
            }).textContentType(.URL)
            
            hasError ? Text("你必须输入符合企业微信机器人协议的 URL").font(.footnote).color(.red) : nil
          }
        }
      }
      .navigationBarTitle("New Robot")
      .navigationBarItems(
        trailing: Button(action: {}) { Text("Save")
      }.disabled(!canSave))
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
