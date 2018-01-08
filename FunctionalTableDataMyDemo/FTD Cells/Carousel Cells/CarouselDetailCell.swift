//
//  CarouselColorsCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//

import Foundation
import UIKit

typealias CarouselDetailCell = HostCell<CarouselCell<CarouselItemDetailCell>, CarouselDetailState, LayoutMarginsTableItemLayout>

struct CarouselDetailState {
	let details: [CarouselItemDetails]
	let didSelectCell: ((IndexPath) -> Void)?
	
	init(details: [CarouselItemDetails], didSelectCell: ((IndexPath) -> Void)?) {
		self.details = details
		self.didSelectCell = didSelectCell
	}
}

extension CarouselDetailState: StateType {
	typealias View = CarouselCell<CarouselItemDetailCell>
	
	static func updateView(_ view: CarouselCell<CarouselItemDetailCell>, state: CarouselDetailState?) {
		guard let state = state else {
			return
		}
		
		view.reload(
			models: state.details,
			didSelectCell: state.didSelectCell,
			collectionHeight: 250,
			minimumLineSpacing: 15)
	}
}

extension CarouselDetailState: Equatable {
	static func ==(lhs: CarouselDetailState, rhs: CarouselDetailState) -> Bool {
		return lhs.details == rhs.details
	}
}
