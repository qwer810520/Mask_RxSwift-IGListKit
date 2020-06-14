//
//  PharmaciesInfoCell.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/13.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class PharmaciesInfoCell: UICollectionViewCell {

  var pharmacie: Pharmacies? {
    didSet {
      guard let pharmacie = pharmacie else { return }
      titleLabel.text = """
      名稱: \(pharmacie.name)
      地址: \(pharmacie.address)
      電話: \(pharmacie.phone)
      成人口罩: \(pharmacie.maskAdult)
      小孩口罩: \(pharmacie.maskAdult)
      備註: \(pharmacie.note)
      """
    }
  }

  lazy private var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20)
    label.numberOfLines = 0
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
    setupContentView()
    contentView.addSubview(titleLabel)

    contentView.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-10-[titleLabel]-10-|",
      options: [],
      metrics: nil,
      views: ["titleLabel": titleLabel]))

    contentView.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-10-[titleLabel]",
      options: [],
      metrics: nil,
      views: ["titleLabel": titleLabel]))
  }

  private func setupContentView() {
    contentView.layer.cornerRadius = 10
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    contentView.layer.borderWidth = 1
  }
}
