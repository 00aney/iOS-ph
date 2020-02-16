//
//  RouteService.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import Foundation


// MARK: - Protocol

protocol RouteServiceProtocol {
  func getRoutes(userId: String, completionHandler: @escaping ([Route]?, Error?) -> Void)
}
  

// MARK: - Class Implementation

final class RouteService {
  
  // MARK: Mock data
  
  private static let routes = [
    Route(id: "b6456760-1df9-4c6e-991b-9b55f0e66519", name: "Toronto", userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6", routePlans: [
      RoutePlan(id: "27999097-04f5-42eb-8f3e-699a2cbab63e",
                name: "Pizza Inc.",
                address: "100 Yonge St, Toronto",
                orderItems: [],
                userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6",
                isSigned: true,
                signImage: nil),
      RoutePlan(id: "48290a17-d8f8-4869-8b77-446a4aaa8632",
                name: "Boston Pizza Inc.",
                address: "20 Sheppard St, Toronto",
                orderItems: [],
                userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6",
                isSigned: true,
                signImage: nil),
      RoutePlan(id: "3a0d1d8a-c21e-42ed-aefc-bf3ca9054dff",
                name: "Millestone Inc.",
                address: "1220 Queen St, Toronto",
                orderItems: [],
                userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6",
                isSigned: true,
                signImage: nil),
      RoutePlan(id: "0e11f427-7f97-48a1-8ebf-cd2708d3b8a7",
                name: "Tech Ichi",
                address: "1020 Bloor St, Toronto",
                orderItems: [],
                userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6",
                isSigned: false,
                signImage: nil),
    ]),
    Route(id: "29f583d5-7239-4461-96ec-41969816ad73", name: "Waterloo", userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6", routePlans: []),
    Route(id: "2488a16d-99ff-4fa7-a9bf-b8280bb01fb8", name: "Guelph", userId: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6", routePlans: []),
  ]
  
  private enum LoginServiceError: Error {
    case invalidUser
  }
}


// MARK: - RouteServiceProtocol

extension RouteService: RouteServiceProtocol {
  func getRoutes(userId: String, completionHandler: @escaping ([Route]?, Error?) -> Void) {
    let userRoutes = RouteService.routes.filter { $0.userId == userId }
    
    completionHandler(userRoutes, nil)
  }
}
