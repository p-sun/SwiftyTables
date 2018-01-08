//
//  CarouselColorsCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-20.
//  Copyright © 2017 TribalScale. All rights reserved.
//

import Foundation
import UIKit

typealias CarouselColorsCell = HostCell<CarouselCell<CarouselItemColorCell>, ColorStripState, LayoutMarginsTableItemLayout>

struct ColorStripState {
    let colors: [UIColor]
    
    init(colors: [UIColor]) {
        self.colors = colors
    }
}

extension ColorStripState: StateType {
    typealias View = CarouselCell<CarouselItemColorCell>

    static func updateView(_ view: CarouselCell<CarouselItemColorCell>, state: ColorStripState?) {
        guard let state = state else {
            return
        }

        view.reload(models: state.colors)
    }
}

extension ColorStripState: Equatable {
    static func ==(lhs: ColorStripState, rhs: ColorStripState) -> Bool {
        return lhs.colors == rhs.colors
    }
}
