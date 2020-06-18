//
//  IGCountyHorizontalSessionController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/17.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import IGListKit

class IGCountyHorizontalSessionController: ListSectionController {

  var county: IGListCounty?

  lazy private var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(),
                              viewController: self.viewController,
                              workingRangeSize: 0)
    adapter.dataSource = self
    return adapter
  }()

  // MARK: - Initialization

  override init() {
    super.init()
    inset = .init(top: 0, left: 10, bottom: 0, right: 10)
    supplementaryViewSource = self
  }

  override func sizeForItem(at index: Int) -> CGSize {
    return .init(width: UIScreen.main.bounds.width, height: 370)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    guard let cell = collectionContext?.dequeueReusableCell(of: IGCountyHorizontalCell.self, for: self, at: index) as? IGCountyHorizontalCell else {
      fatalError("IGCountyHorizontalCell Initialization Fail")
    }
    adapter.collectionView = cell.collectionView
    return cell
  }

  override func didUpdate(to object: Any) {
    county = object as? IGListCounty
  }
}

  // MARK: - ListAdapterDataSource

extension IGCountyHorizontalSessionController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    guard let county = county else { return [] }
    return [county]
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return IGPharmaciesHorizontalController()
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

  // MARK: - ListSupplementaryViewSource

extension IGCountyHorizontalSessionController: ListSupplementaryViewSource {
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
    return .init(width: UIScreen.main.bounds.width, height: 40)
  }
}
