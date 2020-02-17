//
//  QuantityCounterView.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-17.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

protocol QuantityCounterViewDelegate {
  func quantityCounterView(_ quantityCounterView: QuantityCounterView, countChanged: Int) -> Void
}

final class QuantityCounterView: UIView {
  
  // MARK: Properties
  
  var count: Int = 0
  var delegate: QuantityCounterViewDelegate?
  
  
  // MARK: UI
  
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var minusButton: ShadowButton!
  @IBOutlet weak var plusButton: ShadowButton!
  
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  private func setupUI() {
    loadViewFromNib()
    
    layer.cornerRadius = 6
    layer.borderWidth = 1
    layer.borderColor = UIColor.gray.cgColor
    
    countLabel.text = "\(count)"
  }
  
  private func loadViewFromNib() {
    let nib = UINib(nibName: "QuantityCounterView", bundle: nil)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
    
    view.frame = bounds
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    addSubview(view)
  }
  
  
  // MARK: Actions
  
  @IBAction func plusButtonDidTap(_ sender: Any) {
    count += 1
    countLabel.text = "\(count)"
    delegate?.quantityCounterView(self, countChanged: count)
  }
  
  @IBAction func minusButtonDidTap(_ sender: Any) {
    guard count > 0 else { return }
    count -= 1
    countLabel.text = "\(count)"
    delegate?.quantityCounterView(self, countChanged: count)
  }
  
  
  // MARK: configure
  
  func setInitialCount(count: Int) {
    self.count = count
    countLabel.text = "\(count)"
  }
}
