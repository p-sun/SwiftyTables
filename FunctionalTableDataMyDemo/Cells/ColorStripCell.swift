//
//  ColorStripCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD051 on 2017-12-20.
//  Copyright © 2017 TribalScale. All rights reserved.
//

import Foundation

import UIKit

typealias ColorStripCell = HostCell<CarouselCell<ColorStripItemCell>, ColorStripState, LayoutMarginsTableItemLayout>

typealias ColorStripView = CarouselCell<ColorStripItemCell>

struct ColorStripState {
    let colors: [UIColor]
    
    init(colors: [UIColor]) {
        self.colors = colors
    }
}

extension ColorStripState: StateType {
    typealias View = ColorStripView

    static func updateView(_ view: ColorStripView, state: ColorStripState?) {
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
