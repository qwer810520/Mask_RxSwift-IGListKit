//
//  IGCountyHorizontalCell.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/17.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class IGCountyHorizontalCell: UICollectionViewCell {

  lazy private var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return layout
  }()

  lazy var collectionView: UICollectionView = {
    return UICollectionView(layout: flowLayout)
  }()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    contentView.addSubview(collectionView)
  }

  private func setupLayout() {
    contentView.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[collectionView]|",
      options: [],
      metrics: nil,
      views: ["collectionView": collectionView]))

    contentView.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[collectionView]|",
      options: [],
      metrics: nil,
      views: ["collectionView": collectionView]))
  }
}
