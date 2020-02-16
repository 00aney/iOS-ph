//
//  OrderViewController.swift
//  producehero
//
//  Created by Ted Kim on 2020-02-15.
//  Copyright © 2020 Ted Kim. All rights reserved.
//

import UIKit

final class OrderViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
    

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  */

}


struct OrderScene {
  
  let orders: [OrderItem]
  
  func initialViewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "OrderViewController", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! OrderViewController
    return viewController
  }
  
}
