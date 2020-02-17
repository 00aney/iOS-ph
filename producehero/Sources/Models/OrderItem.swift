//
//  OrderItem.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import Foundation

struct OrderItem {
  let id: String
  let name: String
  let weight: Int
  let unit: String
  let quantity: Int
  let price: Double
}


extension OrderItem {
  init(orderItem: OrderItem, quantity: Int? = nil) {
     id = orderItem.id
     name = orderItem.name
     weight = orderItem.weight
     unit = orderItem.unit
     self.quantity = quantity ?? orderItem.quantity
     price = orderItem.price
  }
}
