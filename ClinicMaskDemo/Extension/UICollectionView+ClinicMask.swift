//
//  UICollectionView+ClinicMask.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/13.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

enum CollectionReusableType {
  case header, footer
}

extension CollectionReusableType {
  var kind: String {
    switch self {
      case .header:
        return UICollectionView.elementKindSectionHeader
      case .footer:
        return UICollectionView.elementKindSectionFooter
    }
  }
}

extension UICollectionView {
  func register(with cells: [UICollectionViewCell.Type]) {
     cells.forEach { register($0.self, forCellWithReuseIdentifier: $0.identifier) }
   }

   func registerHeader(with headers: [UICollectionReusableView.Type]) {
     headers.forEach { register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: $0.identifier) }
   }

   func registerFooter(with footers: [UICollectionReusableView.Type]) {
     footers.forEach { register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: $0.identifier) }
   }

   func dequeueReusableCell<T: UICollectionViewCell>(with cell: T.Type, for indexPath: IndexPath) -> T {
     guard let customCell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
       fatalError("\(cell.identifier) Initialization Fail")
     }
     return customCell
   }

   func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofView view: T.Type, withKindType kindType: CollectionReusableType, forIndexPath indexPath: IndexPath) -> T {
     guard let customView = dequeueReusableSupplementaryView(ofKind: kindType.kind, withReuseIdentifier: view.identifier, for: indexPath) as? T else {
       fatalError("\(view.identifier) Initialization Fail")
     }
     return customView
   }
}
