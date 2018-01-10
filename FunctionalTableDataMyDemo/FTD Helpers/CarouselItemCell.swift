//
//  CarouselItemCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-09.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

// All CarouselItemCell are UICollectionViewCell that conforms to this.
protocol CarouselItemCell {
	associatedtype ItemModel
	static func sizeForItem(model: ItemModel) -> CGSize
	func configure(model: ItemModel)
}

extension CarouselItemCell {
	static func reuseId() -> String {
		return String(describing: self)
	}
}

// CarouselItemCell can optionally conform to CarouselItemNibView if there is a cooresponding Nib with the same name
protocol CarouselItemNibView {}

extension CarouselItemNibView {
	static func nibWithClassName() -> UINib {
		return UINib(nibName: String(describing: self), bundle: nil)
	}
}
