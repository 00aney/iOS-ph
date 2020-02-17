//
//  EditOrderItemViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-16.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class EditOrderItemViewController: UIViewController {
  
  // MARK: Properties
  
  var orderItem: OrderItem?
  var saveButtonHandler: ((OrderItem) -> Void)?
  
  
  // MARK: UI
  
  @IBOutlet weak var itemNameLabel: UILabel!
  // item quantity view
  @IBOutlet weak var deleteButton: ShadowButton!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBinding()
  }
    
  private func setupUI() {
    navigationItem.title = "Change Item"
    
    if let orderItem = orderItem {
      itemNameLabel.text = "\(orderItem.name) (\(orderItem.quantity) \(orderItem.unit))"
    } else {
      itemNameLabel.text = ""
    }
    
  }
  
  private func setupBinding() {
     let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonDidTap(_:)))
     navigationItem.rightBarButtonItem = saveButton
  }
  

  // MARK: Actions
  
  @objc func saveButtonDidTap(_ sender: AnyObject) {
    guard let orderItem = orderItem else { return }
    
    saveButtonHandler?(orderItem)
  }
  
  @IBAction func deleteButtonDidTap(_ sender: Any) {
    
  }
  
  // TODO: quantity change handler
}


struct EditOrderItemScene {
  let orderItem: OrderItem
  
  func initialViewController() -> EditOrderItemViewController {
    let storyboard = UIStoryboard(name: "EditOrderItemViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! EditOrderItemViewController
    viewController.orderItem = orderItem
    return viewController
  }
}

