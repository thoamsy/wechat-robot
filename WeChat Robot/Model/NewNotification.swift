//
//  NewNotification.swift
//  WeChat Robot
//
//  Created by yk on 7/27/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI
import Combine

final class NewNotification: BindableObject {
  
  var title: String = "" {
    willSet {
      willChange.send(self)
    }
  }
  var description: String = "" {
    willSet {
      willChange.send(self)
    }
  }
  var url: String = "" {
    willSet {
      willChange.send(self)
    }
  }
  var picurl: String = "" {
    willSet {
     willChange.send(self)
    }
  }
  
//  private let picurlSubscriber: AnySubscriber
//  init() {
//
//  }
  
  let willChange = PassthroughSubject<NewNotification, Never>()
  
  
}
