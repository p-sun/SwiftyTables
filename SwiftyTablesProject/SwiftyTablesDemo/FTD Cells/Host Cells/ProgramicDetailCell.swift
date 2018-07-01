//
//  DoubleDetailCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2018-01-21.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import SwiftyTables

typealias DefaultDetailCell = HostCell<DefaultDetailView, DefaultDetailState, LayoutMarginsTableItemLayout>

struct DefaultDetailState {
    let image: UIImage?
	let title: String?
    let subtitle: String?
    
    init(image: UIImage?, title: String?, subtitle: String?) {
		self.title = title
        self.subtitle = subtitle
        self.image = image
	}
}

extension DefaultDetailState: StateType {
	typealias View = DefaultDetailView
	
	static func updateView(_ view: DefaultDetailView, state: DefaultDetailState?) {
		guard let state = state else {
			return
		}
		
        view.imageView?.image = state.image
        view.textLabel?.text = state.title
        view.detailTextLabel?.text = state.subtitle
        view.textLabel?.numberOfLines = 0
	}
}

extension DefaultDetailState: Equatable {
	static func ==(lhs: DefaultDetailState, rhs: DefaultDetailState) -> Bool {
		return lhs.title == rhs.title
        // TODO
	}
}

class DefaultDetailView: UITableViewCell {
    init() {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")

        heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
