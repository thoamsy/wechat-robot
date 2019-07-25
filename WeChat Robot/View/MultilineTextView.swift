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
  var colorSchema: ColorScheme = ColorScheme.light
  
  let placeholder: String
  
  init(_ text: Binding<String>, placeholder: String = "", with colorSchema: ColorScheme) {
    self._text = text
    self.placeholder = placeholder
    self.colorSchema = colorSchema
  }
  
  class Coordinator: NSObject, UITextViewDelegate {
    var placeholder = ""
    @Binding var text: String
    var colorSchema: ColorScheme
    weak var view: UITextView?
    
    init(_ p: String, text: Binding<String>, with colorSchema: ColorScheme) {
      placeholder = p
      self.colorSchema = colorSchema
      self._text = text
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
      if (textView.text == placeholder) {
        textView.text = ""
        textView.textColor = colorSchema == .dark ? UIColor.white : UIColor.black
      }
      return true
    }
    
    @objc func finishEditing(sender: UIBarButtonItem) {
      text = self.view?.text ?? ""
      self.view?.endEditing(true)
    }
  }

  func makeCoordinator() -> MultilineTextView.Coordinator {
    return Coordinator(placeholder, text: self.$text, with: colorSchema)
  }
  
  
  func makeUIView(context: Context) -> UITextView {
    let view = UITextView()
    view.isScrollEnabled = true
    view.isEditable = true
    view.isUserInteractionEnabled = true
    view.font = .systemFont(ofSize: 20)
    view.delegate = context.coordinator
    context.coordinator.view = view
    view.keyboardDismissMode = .interactive
        
    let bar = UIToolbar()
    let reset = UIBarButtonItem(title: "Done", style: .plain, target: view.delegate, action: #selector(Coordinator.finishEditing(sender:)))
    
    bar.items = [reset]
    bar.sizeToFit()
    
    view.inputAccessoryView = bar
    return view
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
    if (text.isEmpty && !uiView.isFirstResponder) {
      uiView.text = placeholder
      uiView.textColor = .systemGray
    }
  }
  
}
