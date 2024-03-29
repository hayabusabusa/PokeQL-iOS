//
//  MainViewController.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit
import RxCocoa

final class MainViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private let refreshRelay: PublishRelay<Void> = .init()
    private var isFetching: Bool = false // TODO: Refactor
    
    private var dataSource: UICollectionViewDiffableDataSource<MainSection, MainItem>!
    private var viewModel: MainViewModel!
    
    // MARK: Lifecycle
    
    static func instance() -> MainViewController {
        let vc = MainViewController.newInstance()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
        configureViewModel()
    }
    
    // MARK: IBAction
}

// MARK: - Configure

extension MainViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.35))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            group.interItemSpacing = .fixed(4)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 4, leading: 4, bottom: 44, trailing: 4)
            return section
        }
        return layout
    }
    
    func configureNavigation() {
        navigationItem.title = "Main"
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(MainGridCell.nib, forCellWithReuseIdentifier: MainGridCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainSection, MainItem>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.itemType {
            case .grid(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainGridCell.reuseIdentifier, for: indexPath) as! MainGridCell
                cell.configureCell(model.image ?? "")
                return cell
            }
        }
    }
    
    func configureViewModel() {
        viewModel = MainViewModel(dependency: MainViewModel.Dependency(model: MainModelImpl()),
                                  input: MainViewModel.Input(refreshSignal: refreshRelay.asSignal()))
        viewModel.output.pokemonsDriver
            .drive(onNext: { [weak self] pokemons in
                guard let self = self else { return }
                self.isFetching = false // TODO: Refactor
                self.updateUI(pokemons: pokemons)
            })
            .disposed(by: disposeBag)
        viewModel.output.errorDriver
            .drive(onNext: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Update snapshot

extension MainViewController {
    
    func updateUI(pokemons: [PokemonsQuery.Data.Pokemon]) {
        // ここをViewではない層で変換してここに流してきたい。
        let identifiers = pokemons.map { MainItem(itemType: .grid(model: $0)) }
        
        var snapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
        snapshot.appendSections([.grid])
        snapshot.appendItems(identifiers, toSection: .grid)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y + collectionView.frame.size.height > collectionView.contentSize.height &&
            collectionView.isDragging &&
            !isFetching {
            isFetching = true
            refreshRelay.accept(())
        }
    }
}
