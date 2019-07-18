//
//  RobotStore.swift
//  WeChat Robot
//
//  Created by yk on 7/10/19.
//  Copyright © 2019 yk. All rights reserved.
//

import Combine
import SwiftUI

public extension UserDefaults {
  func set<T: Codable>(object: T, forKey key: String) throws {
    let jsonData = try JSONEncoder().encode(object)
    set(jsonData, forKey: key)
  }

  func get<T: Decodable>(objectType: T.Type, forKey key: String) throws -> T? {
    guard let result = value(forKey: key) as? Data else {
      return nil
    }

    return try JSONDecoder().decode(objectType, from: result)
  }
}

@propertyWrapper
struct UserDefault<T: Codable> {
  let key: String
  let defaultValue: T
  var store: T?

  init(initialValue: T, key: String) {
    defaultValue = initialValue
    self.key = key
  }

  var wrappedValue: T {
    mutating get {
      guard let store = store else {
        let value = try! UserDefaults.standard.get(objectType: T.self, forKey: key) ?? defaultValue
        self.store = value
        return value
      }
      return store
    }
    set {
      try! UserDefaults.standard.set(object: newValue, forKey: key)
      self.store = newValue
    }
  }
}

final class RobotStore: BindableObject {
  let willChange = PassthroughSubject<RobotStore, Never>()

  @UserDefault(key: "ROBOT_LIST")
  var robots: [Robot] = [] {
    willSet {
      willChange.send(self)
    }
  }

  init() {
  }

  init(robots: [Robot]) {
    self.robots = robots
  }
}
