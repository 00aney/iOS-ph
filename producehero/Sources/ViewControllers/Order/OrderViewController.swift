//
//  OrderViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class OrderViewController: UIViewController {

  // MARK: Constants
  
  let rowHeight: CGFloat = 80
  
  
  // MARK: Properties
  
  var routePlanId: String = ""
  var isSigned = false
  var orderItems: [OrderItem] = []
  
  var signCompletionHandler: ((_ routePlanId: String, _ sigendImage: UIImage) -> Void)?
  var orderChangeHandler: ((_ routePlanId: String, _ orderItems: [OrderItem]) -> Void)?
  
  // MARK: UI
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBinding()
  }
  
  private func setupUI() {
    navigationItem.title = "Orders"
  }
  
  private func setupBinding() {
    if !isSigned {
      let signButton = UIBarButtonItem(title: "Sign", style: .plain, target: self, action: #selector(signButtonDidTap(_:)))
      navigationItem.rightBarButtonItem = signButton
    }
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let orderItemCell = UINib(nibName: "OrderItemCell", bundle: nil)
    tableView.register(orderItemCell, forCellReuseIdentifier: "OrderItemCell")
  }
  
  
  // MARK: Actions
  
  @objc func signButtonDidTap(_ sender: AnyObject) {
    let totalPrice = calculateTotalPrice(orderItems: orderItems)
    let SignOrderViewController = SignOrderScene(totalPrice: totalPrice).initialViewController()
    
    // MARK: signCompletionHandler
    SignOrderViewController.signCompletionHandler = { [weak self] (image) in
      guard let self = self else { return }
      guard let signCompletionHandler = self.signCompletionHandler else { return }
      
      self.isSigned = true
      signCompletionHandler(self.routePlanId, image)
    }
    SignOrderViewController.modalPresentationStyle = .fullScreen
    present(SignOrderViewController, animated: true, completion: nil)
  }
  
  private func calculateTotalPrice(orderItems: [OrderItem]) -> Double {
    return orderItems.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
  }
  
}


// MARK: - UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}


// MARK: - UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return orderItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
    
    cell.configure(orderItems[indexPath.row], isSigned: isSigned)
    cell.adjustButtonHandler = { [weak self] (cell) in
      guard let self = self else { return }
      
      let editOrderItemViewController = EditOrderItemScene(orderItem: self.orderItems[indexPath.row]).initialViewController()
      editOrderItemViewController.saveButtonHandler = { [weak self] (orderItem) in
        guard let self = self else { return }
        if let index = self.orderItems.firstIndex(where: { $0.id == orderItem.id }) {
          let newOrderItem = OrderItem(orderItem: orderItem)
          self.orderItems.remove(at: index)
          self.orderItems.insert(newOrderItem, at: index)
        }
        self.orderChangeHandler?(self.routePlanId, self.orderItems)
        
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      editOrderItemViewController.deleteHandler = { [weak self] (orderItemId) in
        guard let self = self else { return }
        let newOrderItems = self.orderItems.filter { $0.id != orderItemId }
        self.orderItems = newOrderItems
        self.orderChangeHandler?(self.routePlanId, self.orderItems)
        
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      self.navigationController?.pushViewController(editOrderItemViewController, animated: true)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }
  
}


struct OrderScene {
  
  let routePlanId: String
  let isSigned: Bool
  let orderItems: [OrderItem]
  
  func initialViewController() -> OrderViewController {
    let storyboard = UIStoryboard(name: "OrderViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! OrderViewController
    viewController.routePlanId = routePlanId
    viewController.isSigned = isSigned
    viewController.orderItems = orderItems
    return viewController
  }
  
}
