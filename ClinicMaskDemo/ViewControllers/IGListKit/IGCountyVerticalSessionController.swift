//
//  IGCountyVerticalSectionController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/16.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import IGListKit

class IGCountyVerticalSectionController: ListSectionController {

  private var county: IGListCounty?

  // MARK: - Initialization

  override init() {
    super.init()
    inset = .init(top: 10, left: 10, bottom: 10, right: 10)
    minimumLineSpacing = 10
    supplementaryViewSource = self
  }

  // MARK: - ListSectionController

  override func sizeForItem(at index: Int) -> CGSize {
    return .init(width: ((collectionContext?.containerSize.width ?? 0) - 30) / 2, height: 450)
  }

  override func numberOfItems() -> Int {
    return county?.items.count ?? 0
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    guard let cell = collectionContext?.dequeueReusableCell(of: PharmaciesInfoCell.self, for: self, at: index) as? PharmaciesInfoCell else {
      fatalError("PharmaciesInfoCell Initialization Fail")
    }
    cell.backgroundColor = .white
    cell.pharmacie = county?.items[index]
    return cell
  }

  override func didUpdate(to object: Any) {
    county = object as? IGListCounty
  }

  override func didSelectItem(at index: Int) {
    print("did Select index: \(index)")
  }
}

  // MARK: - ListSupplementaryViewSource

extension IGCountyVerticalSectionController: ListSupplementaryViewSource {
  func supportedElementKinds() -> [String] {
    return [UICollectionView.elementKindSectionHeader]
  }

  func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
    guard let header = collectionContext?.dequeueReusableSupplementaryView(ofKind: elementKind, for: self, class: CountyHeaderView.self, at: index) as? CountyHeaderView else {
      fatalError("CountyHeaderView Initialization Fail")
    }
    header.titleLabel.text = county?.countyName
    return header
  }

  func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
    return .init(width: collectionContext?.containerSize.width ?? 0, height: 40)
  }
}
