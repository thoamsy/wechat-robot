//
//  NewsPreview.swift
//  WeChat Robot
//
//  Created by yk on 7/31/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI
import SafariServices

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
  let linkURL: URL?
  @State private var goURL = false

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
        width: 1,
        cornerRadius: 8
      )
      .tapAction {
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
      NewsPreview(title: "ios bu duo", desc: "", linkURL: URL(string: "https://www.baidu.com"))
    }
  }
#endif
