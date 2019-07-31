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
    HStack(alignment: .center) {
      Text(label).font(.headline)
        .multilineTextAlignment(.leading)
        .lineLimit(1).frame(width: 100)

      TextField(placeholder, text: $text)
        .foregroundColor(.black)
        .background(Color["eff3ef"]!)
    }.frame(height: 44)
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
      ScrollView {
        LabelTextField(label: "标题", text: $news.title)
        LabelTextField(label: "跳转链接", text: $news.url)
        LabelTextField(label: "描述", text: $news.description)
        LabelTextField(label: "图片链接", text: $news.picurl)
      }.listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      }
      
      Section(header: Text("预览")) {
          HStack(alignment: .center) {
            Spacer()
            NewsPreview(
                title: news.title,
                desc: news.description,
                url: news.url
            )
            Spacer()
          }.padding([.top], 15)
      }
    }
  }
}

#if DEBUG
  struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
      NewsTypeView(.init())
    }
  }
#endif
