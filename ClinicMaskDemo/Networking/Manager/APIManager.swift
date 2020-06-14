//
//  APIManager.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class APIManager: NSObject {

  static let shared = APIManager()

  let provider = MoyaProvider<APIType>()

  enum Keys: String {
    case features
  }

  func fetchClinicData() -> Observable<[County]> {
    return provider.rx.request(.fetchClinicData)
      .asObservable()
      .filterSuccessfulStatusCodes()
      .map([Pharmacies].self, atKeyPath: Keys.features.rawValue)
      .map { pharmacies in
        return Dictionary(grouping: pharmacies) { $0.county }
          .map { County(info: $0) }
      }
  }
}
