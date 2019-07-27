//
//  Color.swift
//  WeChat Robot
//
//  Created by yk on 7/27/19.
//  Copyright © 2019 yk. All rights reserved.
//

import SwiftUI

extension Color {
  public static subscript(_ rgb: String) -> Color? {
    var start = rgb.startIndex
    var next = rgb.index(after: start)
    guard let r = Int(rgb[start ... next], radix: 16) else { return nil }
    
    start = rgb.index(after: next)
    next = rgb.index(after: start)
    
    guard let g = Int(rgb[start ... next], radix: 16) else {
      return nil
    }
    
    start = rgb.index(after: next)
    next = rgb.index(after: start)
    guard let b = Int(rgb[start ... next], radix: 16) else {
      return nil
    }
    return Color(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0, opacity: 1.0)
  }
}
