//
//  NewsPreview.swift
//  WeChat Robot
//
//  Created by yk on 7/31/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SafariServices
import SwiftUI

struct SFView: UIViewControllerRepresentable {
  let url: URL
  func makeUIViewController(context: Context) -> SFSafariViewController {
    let sf = SFSafariViewController(url: url)
    return sf
  }

  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFView>) {
  }
}

struct NewsPreview: View {
  let title: String
  let desc: String
  private var linkURL: URL? {
    if let url = URL(string: self.url) {
      return url
    } else {
      return nil
    }
  }

  var url: String
  @State private var goURL = false

  init(title: String, desc: String, url: String) {
    self.title = title
    self.desc = desc
    self.url = url
  }

  var body: some View {
    VStack(alignment: .leading) {
      Image("gg")
        .resizable()
        .scaledToFill()
        .frame(width: 300, height: 150)
        .clipped()

      VStack(alignment: .leading) {
        Text(title).font(.title)
        Text(desc)
          .font(.body)
          .foregroundColor(.gray)
      }.padding([.leading, .bottom], 15)
    }.frame(width: 300)
      .border(
        Color.secondary,
        width: 1
      )
      .cornerRadius(8)
      .onTapGesture {
        if let _ = self.linkURL {
          self.goURL = true
        }
      }
      .sheet(isPresented: $goURL) {
        SFView(url: self.linkURL!)
      }
  }
}

#if DEBUG
  struct NewsPreview_Previews: PreviewProvider {
    static var previews: some View {
      NewsPreview(title: "ios bu duo", desc: "", url: "https://www.baidu.com")
    }
  }
#endif
