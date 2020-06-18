//
//  IGPharmaciesHorizontalController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/17.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import IGListKit

class IGPharmaciesHorizontalController: ListSectionController {

  var county: IGListCounty?

  // MARK: - Initialization

  override init() {
    super.init()
    inset = .init(top: 0, left: 10, bottom: 0, right: 10)
    minimumLineSpacing = 20
  }

  // MARK: - ListSectionController

  override func sizeForItem(at index: Int) -> CGSize {
    return .init(width: 300, height: 350)
  }

  override func numberOfItems() -> Int {
    return county?.items.count ?? 0
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    guard let cell = collectionContext?.dequeueReusableCell(of: PharmaciesInfoCell.self, for: self, at: index) as? PharmaciesInfoCell else {
      fatalError("PharmaciesInfoCell Initialization Fail")
    }
    cell.pharmacie = county?.items[index]
    return cell
  }

  override func didUpdate(to object: Any) {
    county = object as? IGListCounty
  }
}
