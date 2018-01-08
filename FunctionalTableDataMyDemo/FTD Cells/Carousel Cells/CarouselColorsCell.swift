//
//  CarouselColorsCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//

import Foundation
import UIKit

typealias CarouselColorsCell = HostCell<CarouselCell<CarouselItemColorCell>, ColorStripState, LayoutMarginsTableItemLayout>

struct ColorStripState {
    let colors: [UIColor]
	let didSelectCell: ((IndexPath) -> Void)?
    
    init(colors: [UIColor], didSelectCell: ((IndexPath) -> Void)?) {
        self.colors = colors
		self.didSelectCell = didSelectCell
    }
}

extension ColorStripState: StateType {
    typealias View = CarouselCell<CarouselItemColorCell>

    static func updateView(_ view: CarouselCell<CarouselItemColorCell>, state: ColorStripState?) {
        guard let state = state else {
            return
        }

		view.reload(
			models: state.colors,
			didSelectCell: state.didSelectCell,
			collectionHeight: 120,
			minimumLineSpacing: 16)
    }
}

extension ColorStripState: Equatable {
    static func ==(lhs: ColorStripState, rhs: ColorStripState) -> Bool {
        return lhs.colors == rhs.colors
    }
}
