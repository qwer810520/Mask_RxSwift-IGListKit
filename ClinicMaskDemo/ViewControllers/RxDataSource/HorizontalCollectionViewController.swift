//
//  HorizontalCollectionViewController.swift
//  ClinicMaskDemo
//
//  Created by Min on 2020/6/13.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HorizontalCollectionViewController: UIViewController {

  var countys = BehaviorRelay<[County]>(value: [])
  private let disposeBag = DisposeBag()

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(layout: flowLayout)
    collectionView.register(with: [PharmaciesInfoCell.self])
    return collectionView
  }()

  lazy private var flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 20
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    layout.itemSize = .init(width: 300, height: 280)
    layout.scrollDirection = .horizontal
    return layout
  }()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    bindDataSource()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupUserInterface()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    view.backgroundColor = .systemBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    setupLayout()
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

  private func bindDataSource() {
    let dataSource = RxCollectionViewSectionedReloadDataSource<County>.init(configureCell: { (_ , collectionView, indexPath, items) -> UICollectionViewCell in
      let cell = collectionView.dequeueReusableCell(with: PharmaciesInfoCell.self, for: indexPath)
      cell.pharmacie = items
      return cell
    },configureSupplementaryView: nil)

    countys
      .asObservable()
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
