//
//  LoginService.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import Foundation


// MARK: - Protocol

protocol LoginServiceType {
  func login(id: String, password: String, completion: @escaping (User?, Error?) -> Void)
}
  

// MARK: - Class Implementation

final class LoginService {
  
  // MARK: Mock data
  
  private static let users = [
    User(id: "c9368bf6-eb9a-44e7-9d6e-73d159adc2c6", userId: "qweqwe", password: "qweqwe"),
  ]
  
  private enum LoginServiceError: Error {
    case invalidUser
  }
}


// MARK: - LoginServiceType

extension LoginService: LoginServiceType {
  func login(id: String, password: String, completion: @escaping (User?, Error?) -> Void) {
    let users = LoginService.users.filter { (user) -> Bool in
      return user.userId == id && user.password == password
    }
    
    if users.count > 0 {
      completion(users[0], nil)
    } else {
      completion(nil, LoginServiceError.invalidUser)
    }
  }
}
