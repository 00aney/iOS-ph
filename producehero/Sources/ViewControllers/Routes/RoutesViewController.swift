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
  
  var isSigned: Bool = false;
  var user: User?
  
  
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
      // TODO: show lists
      print(user)
    }
  }
  
  private func setupUI() {
    navigationItem.title = "Routes"
  }
  
  private func setupBinding() {
    let barButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutButtonDidTap(_:)))
    navigationItem.leftBarButtonItem = barButton
  }
  
  @objc func signOutButtonDidTap(_ sender: AnyObject) {
    presentLoginViewController(animated: true)
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

