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

  // MARK: - Initialization

  override init() {
    super.init()
  }
}

  // MARK: - ViewModelType

extension CountyPageViewModel: ViewModelType {

  struct Input {
    let fetchPharmacieTrigger: Observable<Void>
  }

  struct Output {
    let countys: BehaviorRelay<[CountySection]>
  }

  func transform(input: Input) -> Output {
    let countyInfo = BehaviorRelay<[CountySection]>(value: [])
    input.fetchPharmacieTrigger
      .flatMapLatest { (_) -> Observable<[County]> in
        return APIManager.shared.fetchClinicData()
      }
      .map({ countys in
        countys.map { CountySection(header: $0.header, items: [$0]) }
      })
      .bind(to: countyInfo)
      .disposed(by: disposebag)
    return Output(countys: countyInfo)
  }
}
