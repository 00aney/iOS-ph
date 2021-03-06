//
//  ViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-14.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class RoutesViewController: UIViewController {

  // MARK: Constants
  
  let rowHeight: CGFloat = 40
  
  
  // MARK: Properties
  
  var routeService: RouteServiceProtocol!
  var user: User? = nil
  var routes: [Route] = []
  
  
  // MARK: UI
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupBinding()
    
    if user == nil {
      presentLoginViewController(animated: true)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    if let user = user {
      routeService.getRoutes(userId: user.id, completionHandler: { [weak self] (routes, error) in
        guard let self = self else { return }
        
        if let routes = routes {
          self.routes = routes
          DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
          }
        }
      })
    }
  }

  private func setupUI() {
    navigationItem.title = "Routes"
    
    let tableFooterView = UIView()
    tableView.backgroundColor = .secondarySystemBackground
    tableFooterView.backgroundColor = tableView.backgroundColor
    tableView.tableFooterView = tableFooterView
  }
  
  private func setupBinding() {
    let barButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutButtonDidTap(_:)))
    navigationItem.leftBarButtonItem = barButton
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
  }
  
  @objc func signOutButtonDidTap(_ sender: AnyObject) {
    presentLoginViewController(animated: true)
    user = nil
    routes = []
  }
  
  private func presentLoginViewController(animated: Bool) {
    let loginViewController = LoginScene(loginService: LoginService(), from: self).initialViewController()
    loginViewController.modalPresentationStyle = .fullScreen
    loginViewController.modalTransitionStyle = .crossDissolve
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.present(loginViewController, animated: animated) {
        loginViewController.modalTransitionStyle = .coverVertical
      }
    }
  }
}


// MARK: - UITableViewDelegate

extension RoutesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    
    guard let navigationController = navigationController else { return }
    
    let item = routes[indexPath.row]

    let routePlanViewController = RoutePlanScene(routePlans: item.routePlans, routeName: item.name).initialViewController()
    navigationController.pushViewController(routePlanViewController, animated: true)
  }
}


// MARK: - UITableViewDataSource

extension RoutesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return rowHeight
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return routes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    // configure cell
    let item = routes[indexPath.row]
    cell.textLabel?.text = item.name
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
}

