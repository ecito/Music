//
//  ContainerCollectionViewCell.swift
//  Music
//
//  Created by Andre Navarro on 3/5/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

fileprivate func makeDefaultLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let margin = CGFloat(16)

    layout.scrollDirection = .vertical
    layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
    layout.minimumLineSpacing = 4
    layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: 0, right: 0)

    return layout
}

// formatting?
public final class GenericCollectionViewController<
    TitleView: UIView,
    CellView: UIView,
    TitleContainer: ContainerCollectionSupplementaryView<TitleView>,
    CellContainer: ContainerCollectionViewCell<CellView>
    >:
    UICollectionViewController {

    public init(viewType: CellView.Type,
                sectionTitleViewType: TitleView.Type? = nil,
                layout: UICollectionViewLayout? = nil) {
        
        super.init(collectionViewLayout: layout ?? makeDefaultLayout())
        
        if sectionTitleViewType != nil {
            let sectionTitleElementKind = "title-kind"
            let sectionTitleReuseIdentifier = "title-id"
            
            self.collectionView.register(TitleContainer.self, forSupplementaryViewOfKind: sectionTitleElementKind, withReuseIdentifier: sectionTitleReuseIdentifier)
        }
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    public var numberOfItems: (Int) -> Int = { _ in 0 } {
        didSet {
            collectionView?.reloadData()
        }
    }

    public var numberOfSections: () -> Int = { 0 } {
        didSet {
            collectionView?.reloadData()
        }
    }

    public var configureView: (IndexPath, CellView) -> () = { _, _ in } {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    public var configureTitle: (IndexPath, TitleView) -> () = { _, _ in } {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    public var didSelectView: (IndexPath, CellView) -> () = { _, _ in }

    public override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(CellContainer.self, forCellWithReuseIdentifier: "cell")
    }

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections()
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems(section)
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellContainer else {
            fatalError("Unexpected cell type dequeued from collection view")
        }

        configureView(indexPath, cell.view)

        return cell
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CellContainer else { return }

        didSelectView(indexPath, cell.view)
    }

    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let title = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "title-id", for: indexPath) as? TitleContainer else {
            fatalError("unexpected supplementary type dequeued from collection view")
        }
        
        configureTitle(indexPath, title.view)
        
        return title
    }
}
