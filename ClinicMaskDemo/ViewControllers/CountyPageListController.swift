//
//  CountyPageListController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/11.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CountyPageListController: UIViewController {

  private var viewModel: CountyPageViewModel?
  private let disposeBag = DisposeBag()
  private let fetchPharmacieTrigger = PublishSubject<Void>()

  lazy private var segmentedControl: UISegmentedControl = {
    let view = UISegmentedControl(items: ["collectionView", "IGListKit"])
    view.selectedSegmentIndex = 0
    return view
  }()

  lazy private var rxCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .white
    collectionView.registerHeader(with: [CountyHeaderView.self])
    collectionView.register(with: [HorizontalCollectionViewCell.self])
    return collectionView
  }()

  lazy private var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = .zero
    layout.itemSize = .init(width: view.frame.width, height: 300)
    layout.headerReferenceSize = .init(width: view.frame.width, height: 40)
    return layout
  }()

  lazy private var indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.startAnimating()
    return indicator
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
    setUserInterface()
  }

  // MARK: - Private Methods

  private func setUserInterface() {
    view.addSubview(rxCollectionView)
    view.addSubview(indicator)
    navigationItem.titleView = segmentedControl
    setupLayout()
  }

  private func setupLayout() {
    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[collectionView]|",
      options: [],
      metrics: nil,
      views: ["collectionView": rxCollectionView]))

    view.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[collectionView]|",
      options: [],
      metrics: nil,
      views: ["collectionView": rxCollectionView]))

    indicator.center = view.center
  }

  private func bindViewModel() {
    let input = CountyPageViewModel.Input(fetchPharmacieTrigger: fetchPharmacieTrigger)
    let outPut = viewModel?.transform(input: input)

    let dataSource = RxCollectionViewSectionedReloadDataSource<CountySection>.init(configureCell: { (dataSource, collectionView, indexPath, _) -> UICollectionViewCell in
      let cell = collectionView.dequeueReusableCell(with: HorizontalCollectionViewCell.self, for: indexPath)
      cell.horizontalCollectionViewVC.countys.accept(dataSource[indexPath.section].items)
      return cell
    }, configureSupplementaryView: { (dataSource, collectionView, _, indexPath) -> UICollectionReusableView in
      let header = collectionView.dequeueReusableSupplementaryView(ofView: CountyHeaderView.self, withKindType: .header, forIndexPath: indexPath)
      header.titleLabel.text = "\(dataSource[indexPath.section].header)"
      return header
    })

    outPut?.countys
      .asObservable()
      .bind(to: rxCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)

    outPut?.countys
      .asObservable()
      .map({ $0.isEmpty })
      .bind(to: indicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }
}
