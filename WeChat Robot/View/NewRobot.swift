//
//  NewRobot.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct NewRobot : View {
  @Environment(\.isPresented) var isPresented: Binding<Bool>?
  @EnvironmentObject var store: RobotStore
  @State private var title: String = ""
  @State private var urlString: String = ""
  @State private var hasError = false
  @State private var canSave = false
  
  private func saveRobot() {    store.robots.append(Robot(title: self.title, url: self.urlString))
    isPresented?.wrappedValue = false
  }
  
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
          trailing: Button(action: self.saveRobot) { Text("Save")
          }.disabled(!canSave))
    }
  }
}

#if DEBUG
struct NewRobot_Previews : PreviewProvider {
  static var previews: some View {
    NewRobot().environmentObject(RobotStore())
  }
}
#endif
