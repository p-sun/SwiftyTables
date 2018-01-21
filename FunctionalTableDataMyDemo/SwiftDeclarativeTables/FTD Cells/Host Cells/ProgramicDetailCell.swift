//
//  DoubleProgramicDetailCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2018-01-21.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

typealias ProgramicDetailCell = HostCell<ProgramicDetailView, ProgramicDetailState, LayoutMarginsTableItemLayout>

struct ProgramicDetailState {
	let title: String
	
	init(title: String) {
		self.title = title
	}
}

extension ProgramicDetailState: StateType {
	typealias View = ProgramicDetailView
	
	static func updateView(_ view: ProgramicDetailView, state: ProgramicDetailState?) {
		guard let state = state else {
			return
		}
		
		view.titleLabel.text = state.title
	}
}

extension ProgramicDetailState: Equatable {
	static func ==(lhs: ProgramicDetailState, rhs: ProgramicDetailState) -> Bool {
		return lhs.title == rhs.title
	}
}

class ProgramicDetailView: UIView {
	var titleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		titleLabel.numberOfLines = 2
		addSubviewsForAutolayout(titleLabel)
		titleLabel.constrainToFillView(self)
		
		backgroundColor = .green
		heightAnchor.constraint(equalToConstant: 90).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
