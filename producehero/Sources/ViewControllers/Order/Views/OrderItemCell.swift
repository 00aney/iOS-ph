//
//  OrderItemCell.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-16.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class OrderItemCell: UITableViewCell {
  
  // MARK: Properties
  
  var adjustButtonHandler: ((UITableViewCell) -> Void)?
  
  
  // MARK: UI
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var quantityButton: ShadowButton!
  @IBOutlet weak var unitButton: ShadowButton!
  @IBOutlet weak var adjustButton: ShadowButton!
  
  
  // MARK: Initializing
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  private func setupUI() {
    unitButton.isEnabled = false
    unitButton.setShadowColor(UIColor.ProduceHero.secondaryShadow)
    quantityButton.isEnabled = false
//    quantityButton.setShadowColor(UIColor.ProduceHero.primaryShadow)
  }
  
  
  // MARK: Configuring
  
  func configure(_ orderItem: OrderItem, isSigned: Bool) {
    nameLabel.text = orderItem.name
    unitButton.setTitle("\(orderItem.weight) \(orderItem.unit)", for: .normal)
    quantityButton.setTitle("x\(orderItem.quantity)", for: .normal)
    
    adjustButton.isHidden = isSigned
  }
  
  
  // MARK: Actions
  
  @IBAction func adjustButtonDidTap(_ sender: Any) {
    adjustButtonHandler?(self)
  }
  
}
