//
//  MainViewController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/15.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {

  lazy private var segmentedControl: UISegmentedControl = {
    let view = UISegmentedControl(items: ["RxDataSource", "IGListKit"])
    view.selectedSegmentIndex = 0
    return view
  }()

  private var disposeBag = DisposeBag()
  private var rxCountySessionListVC: CountySectionListController?
  private var countyPageListVC: CountyPageListController?

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUserInterface()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    navigationItem.titleView = segmentedControl
    segmentedControl.rx
      .selectedSegmentIndex
      .asObservable()
      .subscribe(onNext: { [weak self] in
        switch $0 {
          case 0: self?.setupCountySessionVC()
          default: self?.setupCountyPageVC()
        }
      })
      .disposed(by: disposeBag)
  }

  private func setupCountySessionVC() {
    if let countyPageListVC = countyPageListVC {
      countyPageListVC.view.removeFromSuperview()
      countyPageListVC.removeFromParent()
    }

    rxCountySessionListVC = CountySectionListController()
    guard let controller = rxCountySessionListVC else { return }
    controller.view.frame = view.frame
    view.addSubview(controller.view)
    addChild(controller)
  }

  private func setupCountyPageVC() {
    if let rxCountySessionListVC = rxCountySessionListVC {
      rxCountySessionListVC.view.removeFromSuperview()
      rxCountySessionListVC.removeFromParent()
    }

    countyPageListVC = CountyPageListController()
    guard let controller = countyPageListVC else { return }
    controller.view.frame = view.frame
    view.addSubview(controller.view)
    addChild(controller)
  }
}
