//
//  DeezerCollectionViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/5/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

protocol DeezerCollectionItemViewModel {
    var title: String { get }
    var imageURL: String { get }
}

protocol DeezerCollectionItemSectionViewModel {
    var title: String { get }
    var items: [DeezerCollectionItemViewModel] { get }
}

typealias DeezerItemCollectionViewController = GenericCollectionViewController<
    UILabel,
    UIImageView,
    ContainerCollectionSupplementaryView<UILabel>,
    ContainerCollectionViewCell<UIImageView>
>

extension DeezerItemCollectionViewController {
    static func deezerLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                              heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                              heightDimension: .absolute(380))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = -30
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: titleSize,
            elementKind: "title-kind",
            alignment: .top)
        section.boundarySupplementaryItems = [titleSupplementary]
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = -150
        
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        
        return layout
    }
}
