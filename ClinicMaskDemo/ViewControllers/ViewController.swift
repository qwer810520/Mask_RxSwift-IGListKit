//
//  ViewController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/10.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  private let disposeBag = DisposeBag()
  private var testList = BehaviorSubject<[Pharmacies]>(value: [])

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUserInterface()
  }

  // MARK: - Private Methods

  private func setUserInterface() {
    view.backgroundColor = .systemPink
    testAPI()
    bindObservable()
  }

  // MARK: - API Methods

  private func testAPI() {
    APIManager.shared.fetchClinicData()
      .bind(to: testList)
      .disposed(by: disposeBag)
  }

  private func bindObservable() {
    testList.subscribe(onNext: { (infoList) in
      print(infoList.count)
    }).disposed(by: disposeBag)
  }
}
