//
//  CountyHeaderView.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/13.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class CountyHeaderView: UICollectionReusableView {

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 24)
    return label
  }()

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
    addSubview(titleLabel)
    setupLayout()
  }

  private func setupLayout() {
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[titleLabel]|",
      options: [],
      metrics: nil,
      views: ["titleLabel": titleLabel]))

    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-20-[titleLabel]|",
      options: [],
      metrics: nil,
      views: ["titleLabel": titleLabel]))
  }
}
