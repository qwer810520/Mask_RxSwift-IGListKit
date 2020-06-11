//
//  Pharmacies.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation

struct Pharmacies: Decodable {
  let id: String
  let name: String
  let phone: String
  let address: String
  let available: String
  let maskAdult: Int
  let maskChild: Int
  let updated: String
  let note: String
  let customNote: String
  let website: String
  let county: String
  let town: String
  let cunli: String
  let servicePeriods: String
  let coordinates: [Double]

  enum BaseKeys: String, CodingKey {
    case properties, geometry
  }

  enum PropertiesKeys: String, CodingKey {
    case id, name, phone, address, mask_adult, mask_child, updated, available, note, custom_note, website, county, town, cunli, service_periods
  }

  enum GeometryKeys: String, CodingKey {
    case coordinates
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: BaseKeys.self)

    let pharmaciesInfo = try values.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
    self.id = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .id) ?? ""
    self.name = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.phone = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .phone) ?? ""
    self.address = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .address) ?? ""
    self.available = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .available) ?? ""
    self.maskAdult = try pharmaciesInfo.decodeIfPresent(Int.self, forKey: .mask_adult) ?? 0
    self.maskChild = try pharmaciesInfo.decodeIfPresent(Int.self, forKey: .mask_child) ?? 0
    self.updated = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .updated) ?? ""
    self.note = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .note) ?? ""
    self.customNote = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .custom_note) ?? ""
    self.website = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .website) ?? ""
    self.county = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .county) ?? ""
    self.town = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .town) ?? ""
    self.cunli = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .cunli) ?? ""
    self.servicePeriods = try pharmaciesInfo.decodeIfPresent(String.self, forKey: .service_periods) ?? ""

    let geometryInfo = try values.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
    self.coordinates = try geometryInfo.decodeIfPresent([Double].self, forKey: .coordinates) ?? []
  }
}
