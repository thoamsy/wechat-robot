//
//  RobotEdit.swift
//  WeChat Robot
//
//  Created by yk on 7/8/19.
//  Copyright © 2019 yk. All rights reserved.
//

import CoreHaptics
import SwiftUI

struct RobotEdit: View {
  var sessionConfig = URLSessionConfiguration.default
  var supportsHaptics: Bool {
    CHHapticEngine.capabilitiesForHardware().supportsHaptics
  }

  var robot: Robot
  @Environment(\.colorScheme) var colorSchema: ColorScheme
  @State var textContent = ""
  @State var isMarkdown = false
  @State var isAll = false
  @State var selected = Robot.MsgTypes.text

  @ObservedObject var news = NewsStore()

  var cantLaunch: Bool {
    if selected == .text {
      return textContent.isEmpty
    }
    return news.title.isEmpty || news.url.isEmpty
  }

  private func hapticIt() {
    guard supportsHaptics else { return }
    let hapticDict = [
      CHHapticPattern.Key.pattern: [
        [CHHapticPattern.Key.event: [
          CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
          CHHapticPattern.Key.time: 0.001,
          CHHapticPattern.Key.eventDuration: 0.3,
        ],
        ],
      ],
    ]
    do {
      let pattern = try CHHapticPattern(dictionary: hapticDict)
      let engine = try CHHapticEngine()
      let player = try engine.makePlayer(with: pattern)

      try engine.start()
      try player.start(atTime: 0)
      engine.stop()
    } catch {
      print(error)
    }
  }

  private func launchNotification() {
    var request = URLRequest(url: robot.api)
    request.httpMethod = "POST"

    var msgType = selected.rawValue
    let msgBody: [String: Any]

    switch selected {
    case .text where isMarkdown:
      msgType = "markdown"
      fallthrough
    case .text:
      msgBody = [
        "mentioned_list": isAll ? ["@all"] : [],
        "content": textContent,
      ]
    case .news:
      msgBody = ["articles": [
        [
          "title": news.title,
          "description": news.description,
          "url": news.url,
          "picurl": news.picurl,
        ],
      ]]
    }

    let body: [String: Any] = [
      "msgtype": msgType,
      msgType: msgBody,
    ]

    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    request.httpBody = jsonData

    URLSession(configuration: sessionConfig).dataTask(with: request) {
      _, _, error in
      guard error != nil else {
        return
      }
      self.hapticIt()
    }.resume()
  }

  private var textView: some View {
    Form {
      Section(header: Text("内容")) {
        HStack {
          MultilineTextView(
            self.$textContent,
            placeholder: "通知点啥呢🤔?",
            with: self.colorSchema)
            .frame(height: 150)
            .font(.body)
        }
      }

      Section(header: Text("配置")) {
        Toggle("是否 @ 所有人", isOn: $isAll)
        Toggle("Markdown", isOn: $isMarkdown)
      }
    }
  }

  var body: some View {
    return VStack(alignment: .leading) {
      Picker("foo", selection: $selected) {
        ForEach(Robot.MsgTypes.allCases, id: \.self) { type in

          Text(type.rawValue.capitalized)
        }
      }.pickerStyle(SegmentedPickerStyle())

      if selected == .text {
        textView
      } else {
        NewsTypeView(news)
      }
    }
    .navigationBarTitle(
      "编辑",
      displayMode: .inline
    )
    .navigationBarItems(
      trailing:
      Button("发送", action: launchNotification).disabled(cantLaunch)
    ).onAppear {
    }
  }
}

#if DEBUG
  struct RobotEdit_Previews: PreviewProvider {
    static var previews: some View {
      RobotEdit(robot: Robot(title: "jl", url: "https://m.lagou.com/jobs/5642749.html"))
    }
  }
#endif
