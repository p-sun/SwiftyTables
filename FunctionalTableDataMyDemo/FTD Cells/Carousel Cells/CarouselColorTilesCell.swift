//
//  CarouselColorTilesCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//

import Foundation
import UIKit

typealias CarouselColorTilesCell = CarouselCell<CarouselItemColorTilesCell>

class CarouselItemColorTilesCell: UICollectionViewCell, CarouselItemCell {
	
	typealias ItemModel = UIColor

	private static let size = CGSize(width: 120, height: 120)
	
	private let colorView = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(colorView)
		colorView.pinToSuperView()
		
		_ = colorView.heightAnchor.activateConstraint(
			equalToConstant:  CarouselItemColorTilesCell.size.height, priority: 999)
		_ = colorView.widthAnchor.activateConstraint(
			equalToConstant:  CarouselItemColorTilesCell.size.width, priority: 999)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	static func sizeForItem(model: ItemModel) -> CGSize {
		return CarouselItemColorTilesCell.size
	}
	
	func configure(model: ItemModel) {
		colorView.backgroundColor = model
	}
}
