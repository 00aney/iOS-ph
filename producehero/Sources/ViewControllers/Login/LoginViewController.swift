//
//  LoginViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

  // MARK: Properties
  
  var loginService: LoginServiceProtocol!
  var from: RoutesViewController?
  
  
  // MARK: UI
  
  @IBOutlet weak var userIdTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signInButton: UIButton!
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupBinding()
  }
  
  private func setupUI() {
    signInButton.layer.cornerRadius = 6
  }
  
  private func setupBinding() {
    userIdTextField.delegate = self
    passwordTextField.delegate = self
  }

  @IBAction func signInButtonDidTap(_ sender: Any) {
    guard let userId = userIdTextField.text,
      let password = passwordTextField.text else { return }
    
    loginService.login(id: userId, password: password) { [weak self] (user, error) in
      guard let self = self else { return }
      
      if let user = user {
        self.from?.user = user
        self.dismiss(animated: true, completion: nil)
      } else {
          // TODO: error alert
      }
    }
  }
}


// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
  // TODO: focus next textfield
}


struct LoginScene {
  
  let loginService: LoginService
  let from: RoutesViewController?
  
  func initialViewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
    viewController.loginService = loginService
    viewController.from = from
    return viewController
  }
  
}
