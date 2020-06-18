//
//  IGListCounty.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/16.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation
import IGListKit

enum StoryType {
  case horizontal, vertical
}

class IGListCounty {
  let type: StoryType
  let countyName: String
  let items: [Pharmacies]

  init(info: (key: String, value: [Pharmacies])) {
    self.countyName = !info.key.isEmpty ? info.key : "未分區"
    self.items = info.value
    self.type = info.value.count <= 80 ? .vertical : .horizontal
  }
}

  // MARK: - ListDiffable

extension IGListCounty: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return self as! NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let county = object as? IGListCounty else { return false }
    return type == county.type
  }
}
