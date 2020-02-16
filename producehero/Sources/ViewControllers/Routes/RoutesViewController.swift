//
//  ViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-14.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

class RoutesViewController: UIViewController {

  // MARK: Properties
  
  var routeService: RouteServiceProtocol!
  
  var isSigned: Bool = false;
  var user: User?
  var routes: [Route] = []
  
  
  // MARK: UI
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupBinding()
    
    if !isSigned {
      presentLoginViewController(animated: true)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    if let user = user {
      routeService.getRoutes(userId: user.id, completionHandler: { [weak self] (routes, error) in
        guard let self = self else { return }
        
        // TODO: reload tableView
        if let routes = routes {
          self.routes = routes
          self.tableView.reloadData()
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
    present(loginViewController, animated: animated) {
      loginViewController.modalTransitionStyle = .coverVertical
    }
  }
}


// MARK: - UITableViewDelegate

extension RoutesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let item = routes[indexPath.row]
    
    // TODO: navigate next page
    print(item)
  }
}


// MARK: - UITableViewDataSource

extension RoutesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
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

