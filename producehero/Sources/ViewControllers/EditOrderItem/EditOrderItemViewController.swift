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
  var deleteHandler: ((_ orderItemId: String) -> Void)?
  
  
  // MARK: UI
  
  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var deleteButton: ShadowButton!
  @IBOutlet weak var quantityCounterView: QuantityCounterView!
  
  
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
    
    if let orderItem = orderItem {
      quantityCounterView.setInitialCount(count: orderItem.quantity)
    }
  }
  
  private func setupBinding() {
    let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonDidTap(_:)))
    navigationItem.rightBarButtonItem = saveButton
    
    quantityCounterView.delegate = self
  }
  

  // MARK: Actions
  
  @objc func saveButtonDidTap(_ sender: AnyObject) {
    guard let orderItem = orderItem else { return }
    saveButtonHandler?(orderItem)
  }
  
  @IBAction func deleteButtonDidTap(_ sender: Any) {
    guard let orderItem = orderItem else { return }
    deleteHandler?(orderItem.id)
  }
}


// MARK: - QuantityCounterViewDelegate

extension EditOrderItemViewController: QuantityCounterViewDelegate {
  func quantityCounterView(_ quantityCounterView: QuantityCounterView, countChanged: Int) {
    guard let orderItem = orderItem else { return }
    let newOrderItem = OrderItem(orderItem: orderItem, quantity: countChanged)
    self.orderItem = newOrderItem
  }
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

