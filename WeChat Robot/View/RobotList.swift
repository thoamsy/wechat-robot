//
//  RobotList.swift
//  WeChat Robot
//
//  Created by yk on 7/6/19.
//  Copyright © 2019 yk. All rights reserved.
//
  
import SwiftUI

struct RobotList : View {
  @State var isPresented = false
  @State var robots: [Robot] = []
  
  private var addRobotButton: some View {
    let icon = Image(systemName: "plus.circle").foregroundColor(.blue).font(.title)
    
    let modal = Modal(NewRobot()) {
      self.isPresented = false
    }
    return Button(action: {
      self.isPresented = true
    }) {
      icon
    }.presentation(isPresented ? modal : nil)
  }
  
  private func delete(at offsets: IndexSet) {
    offsets.forEach {
      robots.remove(at: $0)
    }
  }
  
  private func move(from source: IndexSet, to destination: Int) {
      var remove = [Robot]()
    for index in source {
      remove.append(robots[index])
      robots.remove(at: index)
    }
    robots.insert(contentsOf: remove, at: destination)
  }
  
    var body: some View {
      NavigationView {
        
        List {
          ForEach(robots) {
            robot in
            RobotCell(robot: robot)
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
    Robot(title: "123", url:  "http://pic.baike.soso.com/ugc/baikepic2/36950/20170304204240-436580019.jpg/0")!,
    Robot(title: "434", url:  "http://pic.baike.soso.com/ugc/baikepic2/36950/20124234304204240-436580019.jpg/0")!,
    Robot(title: "123", url:  "http://pic.baike.soso.com/ugc/baikepic2/36950/201703234234204240-436580019.jpg/0")!,
  ]
    static var previews: some View {
        RobotList(robots: Self.robots)
    }
}
#endif
