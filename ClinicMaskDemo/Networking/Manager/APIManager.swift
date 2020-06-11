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

  func fetchClinicData() -> Observable<[Pharmacies]> {
    return provider.rx.request(.fetchClinicData)
      .asObservable()
      .filterSuccessfulStatusCodes()
      .map(PharmaciesList.self)
      .map { $0.features }
  }
}
