//
//  CarouselVerticalGridCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2018-01-17.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation


import UIKit

typealias CarouselVerticalGridCell = CarouselCell<CarouselItemVerticalGridCell>

class CarouselItemVerticalGridCell: UICollectionViewCell, CarouselItemCell {
	
	typealias ItemModel = CarouselItemVerticalGridState
	
    private let colorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(colorView)
        colorView.pinToSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func sizeForItem(model: ItemModel, in collectionView: UICollectionView) -> CGSize {
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		
		let totalWidth = collectionView.bounds.size.width
		let contentInset = collectionView.contentInset
		let widthMinusInsets = totalWidth - contentInset.left - contentInset.right
		let widthMinusSpacing = widthMinusInsets - (model.itemsInThisRow - 1) * layout.minimumLineSpacing
		let widthForItem = widthMinusSpacing / model.itemsInThisRow
        return CGSize(width: widthForItem, height: model.height)
    }
	
	static func scrollDirection() -> UICollectionViewScrollDirection {
		return .vertical
	}
	
    func configure(model: ItemModel) {
		self.colorView.backgroundColor = model.color
    }
}

struct CarouselItemVerticalGridState {
	let color: UIColor
	let height: CGFloat
	let itemsInThisRow: CGFloat
	
	init(color: UIColor, height: CGFloat, itemsInThisRow: CGFloat) {
		assert(itemsInThisRow > 0)
		self.color = color
		self.height = height
		self.itemsInThisRow = itemsInThisRow
	}
}

extension CarouselItemVerticalGridState: Equatable {
	static func ==(lhs: CarouselItemVerticalGridState, rhs: CarouselItemVerticalGridState) -> Bool {
		var equality = lhs.color == rhs.color
		equality = equality && lhs.height == rhs.height
		equality = equality && lhs.itemsInThisRow == rhs.itemsInThisRow
		return equality
	}
}
