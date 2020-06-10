//
//  ViewController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/10.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUserInterface()
  }

  // MARK: - Private Methods

  private func setUserInterface() {
    view.backgroundColor = .systemPink
  }
}
