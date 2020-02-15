//
//  ServiceResult.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import Foundation


enum ServiceResult<T> {
  case success(T)
  case failure(Error)
}


enum ServiceError: Error {
  case error
}
