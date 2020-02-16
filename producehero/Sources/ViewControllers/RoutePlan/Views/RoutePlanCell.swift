//
//  RoutePlanCell.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class RoutePlanCell: UITableViewCell {

  // MARK: Properties
  
  var isSigned: Bool = false
  
  var buttonHandler: ((UITableViewCell) -> Void)?
  
  
  // MARK: UI
  
  @IBOutlet weak var button: ShadowButton!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  
  
  // MARK: Initializing
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    setupUI()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  private func setupUI() {
  }
  
  func configure(_ routePlan: RoutePlan) {
    nameLabel.text = routePlan.name
    addressLabel.text = routePlan.address
    isSigned = routePlan.isSigned
    
    print(isSigned)
    
    let buttonTitle = isSigned ? "Signed" : "Map"
    button.setTitle(buttonTitle, for: .normal)
    button.backgroundColor = isSigned ? UIColor.ProduceHero.secondary : UIColor.ProduceHero.primary
  }

  
  // MARK: Actions
  
  @IBAction func buttonDidTap(_ sender: Any) {
    guard !isSigned else { return }
    buttonHandler?(self)
  }
  
}

