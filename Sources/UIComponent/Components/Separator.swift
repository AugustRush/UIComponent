//
//  File.swift
//  
//
//  Created by Luke Zhao on 8/24/20.
//

import UIKit

public struct Separator: ViewComponentBuilder {
  public static var defaultSeparatorColor: UIColor = {
    if #available(iOS 13, *) {
      return UIColor.systemGroupedBackground
    } else {
      return UIColor.lightGray
    }
  }()
  
  public let id: String
  public let color: UIColor

  public init(id: String = UUID().uuidString, color: UIColor = Separator.defaultSeparatorColor) {
    self.id = id
    self.color = color
  }

  public func build() -> some ViewComponent {
    SimpleViewComponent<UIView>(id: id).backgroundColor(color).constraint { constraint in
      if constraint.minSize.height <= 0, constraint.maxSize.width != .infinity {
        let size = CGSize(width: constraint.maxSize.width, height: 1 / UIScreen.main.scale)
        return Constraint(minSize: size, maxSize: size)
      } else if constraint.minSize.width <= 0, constraint.maxSize.height != .infinity {
        let size = CGSize(width: 1 / UIScreen.main.scale, height: constraint.maxSize.height)
        return Constraint(minSize: size, maxSize: size)
      }
      return constraint
    }
  }
}
