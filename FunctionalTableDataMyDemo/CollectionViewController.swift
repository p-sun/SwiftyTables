//
//  CollectionViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD051 on 2017-12-05.
//  Copyright © 2017 TribalScale. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    let functionalData = FunctionalCollectionData()
    let reuseIdentifier = "Cell"

    var items: [String] = [] {
        didSet {
            render()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup functional table data
        functionalData.collectionView = collectionView
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Setup view
        collectionView?.backgroundColor = .groupTableViewBackground
        title = "UICollectionView Demo"
        
        // Use buttons to insert and delete rows
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didSelectAdd))
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didSelectTrash))
        navigationItem.rightBarButtonItems = [addButton, trashButton]
    }
    
    @objc private func didSelectAdd() {
        items.append("\(Int(arc4random_uniform(1500)+1))")
    }
    
    @objc private func didSelectTrash() {
        items = []
    }
    
    func render() {
        let rows: [CellConfigType] = items.enumerated().map { index, item in
//            return LabelCell(
//                key: "id-\(index)",
//                style: CellStyle(backgroundColor: .white),
//                state: LabelState(text: item),
//                cellUpdater: LabelState.updateView)
            return DetailCell(
                key: "id-\(index)",
                state: DetailState(
                    image: #imageLiteral(resourceName: "finedog"),
                    title: "",
                    subtitle: ""),
                cellUpdater: DetailState.updateView)
        }
        
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
            ])
    }
}
