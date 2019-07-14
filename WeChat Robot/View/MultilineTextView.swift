//
//  MultilineTextView.swift
//  WeChat Robot
//
//  Created by yk on 7/14/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

struct MultilineTextView : UIViewRepresentable {
  @Binding var text: String
  
  init(_ text: Binding<String>) {
    self.$text = text
  }
  
  func makeUIView(context: Context) -> UITextView {
    let view = UITextView()
    view.isScrollEnabled = true
    view.isEditable = true
    view.isUserInteractionEnabled = true
    view.font = .systemFont(ofSize: 20)
    
    return view
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
  }
  
}
