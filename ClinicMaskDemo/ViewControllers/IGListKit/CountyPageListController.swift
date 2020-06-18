//
//  CountyPageListController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/15.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

class CountyPageListController: UIViewController {

  private var viewModel: CountyPageViewModel?
  private let fetchPharmacieTrigger = PublishSubject<Void>()
  private let disposeBag = DisposeBag()

  lazy private var indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.startAnimating()
    return indicator
  }()

  lazy private var adapter: ListAdapter = {
    ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
  }()

  lazy private var collectionView: UICollectionView = {
    let collectionView = UICollectionView(layout: flowLayout)
    collectionView.showsVerticalScrollIndicator = true
    return collectionView
  }()

  lazy private var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.sectionInset = .init(top: 0, left: 0, bottom: 10, right: 0)
    return layout
  }()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = CountyPageViewModel()
    bindViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchPharmacieTrigger.onNext(())
    setupUserInterface()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    setupLayout()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    view.addSubview(collectionView)
    adapter.collectionView = collectionView
    adapter.dataSource = self
  }

  private func setupLayout() {
    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[collectionView]|",
      options: [],
      metrics: nil,
      views: ["collectionView": collectionView]))
    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[collectionView]|",
      options: [],
      metrics: nil,
      views: ["collectionView": collectionView]))
  }

  private func bindViewModel() {
    let input = CountyPageViewModel.Input(fetchPharmacieTrigger: fetchPharmacieTrigger)
    let outPut = viewModel?.transform(input: input)

    outPut?.countys
      .asObservable()
      .map({ $0.isEmpty })
      .bind(to: indicator.rx.isAnimating)
      .disposed(by: disposeBag)

    viewModel?.items
      .asObservable()
      .subscribe(onNext: { [weak self] _ in
        self?.adapter.performUpdates(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
}

  // MARK: - ListAdapterDataSource

extension CountyPageListController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    guard let items = viewModel?.items.value else { return [] }
    return items
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    guard let county = object as? IGListCounty else { return ListSectionController() }
    switch county.type {
      case .horizontal:
        return IGCountyHorizontalSessionController()
      case .vertical:
        return IGCountyVerticalSectionController()
    }
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return indicator
  }
}
