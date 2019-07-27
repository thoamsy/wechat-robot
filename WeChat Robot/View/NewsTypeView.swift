//
//  NewsTypeView.swift
//  WeChat Robot
//
//  Created by yk on 7/27/19.
//  Copyright © 2019 yk. All rights reserved.
//

import Combine
import SwiftUI


struct LabelTextField: View {
  let label: String
  var placeholder: String = ""
  @Binding var text: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(label).font(.headline)

      TextField(placeholder, text: $text)
        .padding(.all)
        .background(Color["eff3ef"]!)
    }
  }
}

struct NewsTypeView: View {
  @ObjectBinding var news: NewNotification
  
  
  enum News {
    case title(String)
    case description(String)
    case url(String)
    case picurl(String)
  }
  
  init(_ store: NewNotification) {
    news = store
  }
  

  var body: some View {
    Form {
      Section(header: Text("内容")) {
        LabelTextField(label: "标题", text: $news.title)
        LabelTextField(label: "跳转链接", text: $news.url)
        LabelTextField(label: "描述", text: $news.description)
        LabelTextField(label: "图片链接", text: $news.picurl)
      }
    }.listRowInsets(EdgeInsets())
  }
}

#if DEBUG
  struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
      NewsTypeView(.init())
    }
  }
#endif
