//
//  NewNotification.swift
//  WeChat Robot
//
//  Created by yk on 7/27/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI
import Combine

final class NewsStore: ObservableObject {
  
  @Published var title: String = ""
  @Published var description: String = ""
  @Published var url: String = ""
  @Published var picurl: String = ""
  
}
