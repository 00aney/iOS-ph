//
//  RoutePlan.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import Foundation
import UIKit


struct RoutePlan {
  let id: String
  let name: String
  let address: String
  let orderItems: [OrderItem]
  let userId: String
  let isSigned: Bool
  let signImage: UIImage?
}


extension RoutePlan {
  init(routePlan: RoutePlan, orderItems: [OrderItem]? = nil, isSigned: Bool? = nil, signImage: UIImage? = nil) {
    id = routePlan.id
    name = routePlan.name
    address = routePlan.address
    self.orderItems = orderItems ?? routePlan.orderItems
    userId = routePlan.userId
    self.isSigned = isSigned ?? routePlan.isSigned
    self.signImage = signImage ?? routePlan.signImage
  }
}
