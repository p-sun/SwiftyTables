//
//  CarouselColorsCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//

import Foundation
import UIKit


typealias CarouselDetailCell = HostCell<CarouselView<CarouselItemDetailCell>, CarouselDetailState, LayoutMarginsTableItemLayout>

struct CarouselDetailState {
	var itemModels: [CarouselItemDetails]
	var didSelectCell: ((IndexPath) -> Void)?
	
	init(itemModels: [CarouselItemDetails],
		 didSelectCell: ((IndexPath) -> Void)?) {
		self.itemModels = itemModels
		self.didSelectCell = didSelectCell
	}
}

extension CarouselDetailState: CarouselStateType {
	typealias ItemModel = CarouselItemDetails
	typealias View = CarouselView<CarouselItemDetailCell>
}
