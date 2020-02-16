//
//  RoutePlanViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class RoutePlanViewController: UIViewController {

  // MARK: Properties
  
  var routeName: String = ""
  var routePlans: [RoutePlan] = []
  
  
  // MARK: UI
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBinding()
  }
  
  private func setupUI() {
    navigationItem.title = "\(routeName) Route Plan"
  }
  
  private func setupBinding() {
    tableView.delegate = self
    tableView.dataSource = self
    
    let routePlanCell = UINib(nibName: "RoutePlanCell", bundle: nil)
    
    tableView.register(routePlanCell, forCellReuseIdentifier: "RoutePlanCell")
  }
  
  
}


// MARK: - UITableViewDelegate

extension RoutePlanViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // TODO:
  }
}


// MARK: - UITableViewDataSource

extension RoutePlanViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return routePlans.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RoutePlanCell", for: indexPath) as! RoutePlanCell
    
    let routePlan = routePlans[indexPath.row]
    cell.configure(routePlan)
    // TODO: button handler
    cell.mapButtonHandler = { [weak self] (cell) in
      guard let self = self else { return }
      
      let address = self.routePlans[indexPath.row].address
        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      if let address = address,
        let url = URL(string: "http://maps.apple.com/?address=\(address)") {
        UIApplication.shared.open(url)
      } else {
        print("failed to open url, it was nil.")
      }
    }
    // TODO: UIColor+producehero
  
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}


struct RoutePlanScene {
  
  let routePlans: [RoutePlan]
  let routeName: String
  
  func initialViewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "RoutePlanViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! RoutePlanViewController
    
    viewController.routePlans = routePlans
    viewController.routeName = routeName
    return viewController
  }
}
