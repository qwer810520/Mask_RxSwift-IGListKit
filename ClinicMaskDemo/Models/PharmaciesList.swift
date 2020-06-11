//
//  PharmaciesList.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation

struct PharmaciesList: Decodable {
  let type: String
  let features: [Pharmacies]
}
