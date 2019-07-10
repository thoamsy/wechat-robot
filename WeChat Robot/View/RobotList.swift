//
//  RobotList.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct RobotList : View {
  @EnvironmentObject var store: RobotStore
  
  private var addRobotButton: some View {
    PresentationLink(destination: NewRobot().environmentObject(store)) {
      Image(systemName: "plus.circle").foregroundColor(.blue).font(.title)
    }
  }
  
  private func delete(at offsets: IndexSet) {
    offsets.forEach {
      store.robots.remove(at: $0)
    }
  }
  
  private func move(from source: IndexSet, to destination: Int) {
    var remove = [Robot]()
    for index in source {
      remove.append(store.robots[index])
      store.robots.remove(at: index)
    }
    store.robots.insert(contentsOf: remove, at: destination)
  }
  
  var body: some View {
    NavigationView {
      
      List {
        ForEach(store.robots) {
          robot in
          NavigationLink(destination: RobotEdit(robot: robot)) { RobotCell(robot: robot)
          }
        }
        .onMove(perform: move)
          .onDelete(perform: delete)
      }
      .navigationBarTitle("Robots")
        .navigationBarItems(
          leading: self.addRobotButton,
          trailing: EditButton()
      )
    }
  }
}

#if DEBUG
struct RobotList_Previews : PreviewProvider {
  static var robots = [
    Robot(title: "1232", url:  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb61722"),
    Robot(title: "434", url:  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb61733"),
    Robot(title: "123", url:  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb61755"),
  ]
  static var previews: some View {
    RobotList().environmentObject(RobotStore(robots: Self.robots))
  }
}
#endif
