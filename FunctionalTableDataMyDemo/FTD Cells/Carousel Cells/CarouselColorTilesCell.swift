//
//  CarouselColorTilesCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//

import UIKit

typealias CarouselColorTilesCell = CarouselCell<CarouselItemColorTilesCell>

class CarouselItemColorTilesCell: UICollectionViewCell, CarouselItemCell {
	
	typealias ItemModel = UIColor

	private static let size = CGSize(width: 100, height: 100)
	
	private let colorView = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(colorView)
		colorView.pinToSuperView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	static func sizeForItem(model: ItemModel) -> CGSize {
		return CarouselItemColorTilesCell.size
	}
	
    static func scrollDirection() -> UICollectionViewScrollDirection {
        return .horizontal
    }
    
	func configure(model: ItemModel) {
		colorView.backgroundColor = model
	}
}
