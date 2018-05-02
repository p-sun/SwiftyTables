//
//  SpacerCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2018-01-21.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import DeclarativeTables

typealias SpacerCell = HostCell<SpacerView, SpacerState, LayoutMarginsTableItemLayout>

class SpacerView: UIView {
    var heightConstraint = NSLayoutConstraint()
    
    init() {
        super.init(frame: CGRect.zero)
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct SpacerState: StateType {
    typealias View = SpacerView

    var height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
    }
    
    static func updateView(_ view: SpacerView, state: SpacerState?) {
        guard let state = state else { return }
        view.heightConstraint.constant = state.height
    }
}

extension SpacerState: Equatable {
    static func ==(lhs: SpacerState, rhs: SpacerState) -> Bool {
        return lhs.height == rhs.height
    }
}
