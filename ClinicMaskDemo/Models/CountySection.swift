//
//  CountySection.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/13.
//  Copyright © 2020 Min. All rights reserved.
//

import RxDataSources

struct CountySection {
  let header: String
  var items: [County]
}

extension CountySection: SectionModelType {
  init(original: CountySection, items: [County]) {
    self = original
    self.items = items
  }
}
