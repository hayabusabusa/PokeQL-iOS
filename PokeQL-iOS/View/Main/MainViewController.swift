//
//  MainViewController.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<MainSection, MainItem>!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
    }
    
    func configureCollectionView() {
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
        
        // - Initial
        PokeQLProvider.shared.apolloClient.fetch(query: PokemonsQuery(count: 40)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let pokemons = response.data?.pokemons {
                    var array: [MainItem] = [MainItem]()
                    pokemons.forEach { pokemon in
                        if let pokemon = pokemon {
                            array.append(MainItem(itemType: .grid(model: pokemon)))
                        }
                    }
                    
                    // - snapshot
                    var snapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
                    snapshot.appendSections([.grid])
                    snapshot.appendItems(array, toSection: .grid)
                    self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}
