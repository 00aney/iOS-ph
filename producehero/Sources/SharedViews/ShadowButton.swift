//
//  ShadowButton.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-16.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupButton()
  }
  
  private func setupButton() {
    // Shadow and Radius
    layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    layer.shadowOpacity = 1.0
    layer.shadowRadius = 0.0
    layer.masksToBounds = false
    layer.cornerRadius = 6
  }
  
  func setShadowColor(_ color: UIColor) {
    layer.shadowColor = color.cgColor
  }

}
