//
//  OrderViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class OrderViewController: UIViewController {

  // MARK: Properties
  
  var orderItems: [OrderItem] = []
  
  
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
    let signButton = UIBarButtonItem(title: "Sign", style: .plain, target: self, action: #selector(signButtonDidTap(_:)))
    navigationItem.rightBarButtonItem = signButton
    
    tableView.delegate = self
    tableView.dataSource = self
    
    let orderItemCell = UINib(nibName: "OrderItemCell", bundle: nil)
    tableView.register(orderItemCell, forCellReuseIdentifier: "OrderItemCell")
  }
  
  
  // MARK: Actions
  
  @objc func signButtonDidTap(_ sender: AnyObject) {
    print("sign button did tap")
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
    
    cell.configure(orderItems[indexPath.row])
    cell.adjustButtonHandler = { [weak self] (cell) in
      guard let self = self else { return }
      print("adjust button did tap", self)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
}


struct OrderScene {
  
  let orderItems: [OrderItem]
  
  func initialViewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "OrderViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! OrderViewController
    viewController.orderItems = orderItems
    return viewController
  }
  
}
