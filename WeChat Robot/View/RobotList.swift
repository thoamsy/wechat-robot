//
//  RobotList.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct RobotList: View {
  @EnvironmentObject var store: RobotStore
  @State var showAdding = false

  private var addRobotButton: some View {
    Button(action: {
      self.showAdding = true
    }) {
      Image(systemName: "plus.circle")
       .foregroundColor(.blue)
       .imageScale(.large)
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

  private var list: some View {
    List {
      ForEach(store.robots) {
        robot in
        NavigationLink(destination:
          RobotEdit(robot: robot)
        ) {
          RobotCell(robot: robot)
        }
      }
      .onMove(perform: move)
      .onDelete(perform: delete)
    }
  }

  private var emptyView: some View {
    VStack(alignment: .center) {
      Text("🤖")
        .font(.system(size: 100))
      Text("没有任何机器人")
        .font(.subheadline)
    }
  }

  var body: some View {
    NavigationView {
      if self.store.robots.count > 0 {
        list
          .navigationBarTitle("Robots")
          .navigationBarItems(
            leading: self.addRobotButton,
            trailing: EditButton()
          )
      } else {
        emptyView
          .navigationBarItems(
            leading: self.addRobotButton,
            trailing: EditButton()
          )
      }
    }.sheet(
      isPresented: $showAdding,
      onDismiss: {
        self.showAdding = false
    }) { NewRobot(show: self.$showAdding).environmentObject(self.store)
    }

  }
}

#if DEBUG
  struct RobotList_Previews: PreviewProvider {
    static var robots = [
      Robot(title: "1232", url: "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb61722"),
      Robot(title: "434", url: "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb61733"),
      Robot(title: "123", url: "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2c00c5df-31e1-4fae-9c96-c8202d3bb61755"),
    ]
    static var previews: some View {
      Group {
        RobotList().environmentObject(RobotStore(robots: Self.robots))
        RobotList().environmentObject(RobotStore())
      }
    }
  }
#endif
