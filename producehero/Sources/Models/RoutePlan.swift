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
