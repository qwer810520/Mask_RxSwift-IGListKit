//
//  CountyPageViewModel.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CountyPageViewModel: NSObject {

  private let disposebag = DisposeBag()
  let items = BehaviorRelay<[IGListCounty]>(value: [])

  // MARK: - Initialization

  override init() { super.init() }
}

  // MARK: - ViewModelType

extension CountyPageViewModel: ViewModelType {

  struct Input {
    let fetchPharmacieTrigger: Observable<Void>
  }

  struct Output {
    let countys: BehaviorRelay<[County]>
  }

  func transform(input: Input) -> Output {
    let countyInfo = BehaviorRelay<[County]>(value: [])

    input.fetchPharmacieTrigger
      .flatMapLatest { (_) -> Observable<[County]> in
        return APIManager.shared.fetchPharmaciesData()
      }
      .bind(to: countyInfo)
      .disposed(by: disposebag)

    input.fetchPharmacieTrigger
      .flatMapLatest { _ -> Observable<[IGListCounty]> in
        return APIManager.shared.fetchfetchPharmaciesDataForIGListKit()
      }.map({ countys -> Observable<IGListCounty> in

      })
      .bind(to: items)
      .disposed(by: disposebag)

    return Output(countys: countyInfo)
  }
}
