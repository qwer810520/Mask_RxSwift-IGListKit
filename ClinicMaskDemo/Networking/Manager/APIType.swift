//
//  APIType.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation
import Moya

enum APIType {
  case fetchClinicData
}

extension APIType: TargetType {
  var baseURL: URL {
    guard let url = URL(string: "https://raw.githubusercontent.com") else {
      fatalError("URL Initialization Fail")
    }
    return url
  }

  var path: String {
    return "/kiang/pharmacies/master/json/points.json"
  }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String : String]? {
    return nil
  }
}
