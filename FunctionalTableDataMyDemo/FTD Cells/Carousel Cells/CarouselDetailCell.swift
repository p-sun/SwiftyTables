//
//  CarouselColorTilesCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//

import Foundation
import UIKit

typealias CarouselDetailCell = CarouselCell<CarouselItemDetailCell>

class CarouselItemDetailCell: UICollectionViewCell, CarouselItemCell, CarouselItemNibView {
	
	typealias ItemModel = CarouselItemDetailState
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	static func sizeForItem(model: ItemModel) -> CGSize {
		return CGSize(width: 150, height: 158)
	}
	
	func configure(model: ItemModel) {
		self.imageView.image = model.image
		self.titleLabel.text = model.title
		self.subtitleLabel.text = model.subtitle
	}
}

struct CarouselItemDetailState {
	let image: UIImage?
	let title: String?
	let subtitle: String?
	
	init(image: UIImage?, title: String?, subtitle: String?) {
		self.image = image
		self.title = title
		self.subtitle = subtitle
	}
}

extension CarouselItemDetailState: Equatable {
	static func ==(lhs: CarouselItemDetailState, rhs: CarouselItemDetailState) -> Bool {
		return lhs.image == rhs.image
			&& lhs.title == rhs.title
			&& lhs.subtitle == rhs.subtitle
	}
}
