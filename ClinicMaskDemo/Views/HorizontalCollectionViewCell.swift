//
//  HorizontalCollectionViewCell.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/13.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {

  let horizontalCollectionViewVC = HorizontalCollectionViewController()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func setupUserInterface() {

    guard let view = horizontalCollectionViewVC.view else { return }
    addSubview(view)

    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[view]|",
      options: [],
      metrics: nil,
      views: ["view": view]))

    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[view]|",
      options: [],
      metrics: nil,
      views: ["view": view]))
  }
}
