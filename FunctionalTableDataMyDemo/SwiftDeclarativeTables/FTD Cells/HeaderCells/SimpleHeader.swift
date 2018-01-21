//
//  SimpleHeader.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-12.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

class SimpleHeader: UIView {
	var title: String? {
		didSet {
			titleLabel.text = title
		}
	}
	
	private let titleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.clear
		
		addSubviewsForAutolayout(titleLabel)
		titleLabel.constrainToFillView(self)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

struct SimpleHeaderState: TableHeaderFooterStateType {
	let title: String
	let insets = UIEdgeInsets.zero
	let topSeparatorHidden: Bool = true
	let bottomSeparatorHidden: Bool = true
	var height: CGFloat {
		return 70//insets.top + titleFont.font.lineHeight + insets.bottom
	}
	
	init(title: String = "") {
		self.title = title
	}
}

func SimpleHeaderConfig(_ title: String) -> TableHeaderFooterConfigType {
	
	let state = SimpleHeaderState(title: title)
	
	return TableSectionHeaderFooter<SimpleHeader, LayoutMarginsTableItemLayout, SimpleHeaderState>(state: state, updater: { (header, state) in
		header.view.title = state.title
		header.contentView.layoutMargins = state.insets
		header.topSeparator.isHidden = state.topSeparatorHidden
		header.bottomSeparator.isHidden = state.bottomSeparatorHidden
	})
}
