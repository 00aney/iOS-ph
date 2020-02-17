//
//  SignOrderViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-16.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class SignOrderViewController: UIViewController {
  
  // MARK: Properties
  
  var totalPrice: Double = 0.0
  
  var signCompletionHandler: ((UIImage) -> Void)?
  
  
  // MARK: UI
  
  @IBOutlet weak var clearButton: UIButton!
  @IBOutlet weak var doneButton: ShadowButton!
  @IBOutlet weak var cancelButton: ShadowButton!
  @IBOutlet weak var canvasView: CanvasView!
  @IBOutlet weak var totalPriceLabel: UILabel!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBinding()
  }
  
  func setupUI() {
    clearButton.setTitleColor(UIColor.ProduceHero.primary, for: .normal)
    cancelButton.setTitleColor(.white, for: .normal)
    cancelButton.backgroundColor = UIColor.ProduceHero.danger
    cancelButton.setShadowColor(UIColor.ProduceHero.dangerShadow)
    
    doneButton.setTitleColor(.white, for: .normal)
    doneButton.backgroundColor = UIColor.ProduceHero.primary
    doneButton.setShadowColor(UIColor.ProduceHero.primaryShadow)
    
    totalPriceLabel.text = "$ \(totalPrice)"
  }
  
  func setupBinding() {
  }
  
  
  // MARK: Actions
  
  @IBAction func doneButtonDidTap(_ sender: Any) {
    if let image = canvasView.save() {
      dismiss(animated: true) {
        self.signCompletionHandler?(image)
      }
    } else {
      print("failed to save image")
      // TODO: alert
    }
  }
  
  @IBAction func clearButtonDidTap(_ sender: Any) {
    canvasView.clear()
  }
  
  @IBAction func cancelButtonDidTap(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

}


struct SignOrderScene {
  let totalPrice: Double
  
  func initialViewController() -> SignOrderViewController {
    let storyboard = UIStoryboard(name: "SignOrderViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! SignOrderViewController
    viewController.totalPrice = totalPrice
    return viewController
  }
}
