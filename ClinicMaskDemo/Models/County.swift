//
//  County.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct County {
  let header: String
  let adultMaskCount: Int
  let childMaskCount: Int
  var items: [Pharmacies]

  init(info: (key: String, value: [Pharmacies])) {
    self.header = !info.key.isEmpty ? info.key : "未分區"
    self.adultMaskCount = info.value.reduce(0, { $0 + $1.maskAdult })
    self.childMaskCount = info.value.reduce(0, { $0 + $1.maskChild })
    self.items = info.value
  }

  init() {
    self.header = ""
    self.adultMaskCount = 0
    self.childMaskCount = 0
    self.items = []
  }
}

  // MARK: - SectionModelType

extension County: SectionModelType {
  typealias Item = Pharmacies

  init(original: County, items: [Pharmacies]) {
    self = original
    self.items = items
  }
}
