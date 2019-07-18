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
  let placeholder: String
  
  init(_ text: Binding<String>, placeholder: String = "") {
    self._text = text
    self.placeholder = placeholder
  }
  
  class Coordinator: NSObject, UITextViewDelegate {
    var placeholder = ""
    
    init(_ p: String) {
      placeholder = p
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
      if (textView.text == placeholder) {
        textView.text = ""
        textView.textColor = .black
      }
      return true
    }
  }

  func makeCoordinator() -> MultilineTextView.Coordinator {
    return Coordinator(placeholder)
  }
  
  func makeUIView(context: Context) -> UITextView {
    let view = UITextView()
    view.isScrollEnabled = true
    view.isEditable = true
    view.isUserInteractionEnabled = true
    view.font = .systemFont(ofSize: 20)
    view.delegate = context.coordinator
    return view
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {
    print("Update")
    uiView.text = text
    if (text.isEmpty && !uiView.isFirstResponder) {
      uiView.text = placeholder
      uiView.textColor = .systemGray
    }
  }
  
}
