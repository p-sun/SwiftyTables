//
//  SimpleHeader.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-12.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

public class SimpleHeader: UIView {
	public var title: String? {
		didSet {
			titleLabel.text = title
		}
	}
	
	private let titleLabel = UILabel()
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	private func setup() {
		backgroundColor = UIColor.clear
		
		addSubviewsForAutolayout(titleLabel)
		titleLabel.constrainToFillView(self)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

public struct SimpleHeaderState: TableHeaderStateType {
	public let title: String
	public let insets = UIEdgeInsets.zero
	public let topSeparatorHidden: Bool = true
	public let bottomSeparatorHidden: Bool = true
	public var height: CGFloat {
		return 120//insets.top + titleFont.font.lineHeight + insets.bottom
	}
	
	public init(title: String = "") {
		self.title = title
	}
}

public func SimpleHeaderConfig(_ title: String) -> TableHeaderFooterConfigType {
	
	let state = SimpleHeaderState(title: title)
	
	return TableSectionHeader<SimpleHeader, LayoutMarginsTableItemLayout, SimpleHeaderState>(state: state, updater: { (header, state) in
		header.view.title = state.title
		header.contentView.layoutMargins = state.insets
		header.topSeparator.isHidden = state.topSeparatorHidden
		header.bottomSeparator.isHidden = state.bottomSeparatorHidden
	})
}


public struct TableSectionHeader<ViewType: UIView, Layout: TableItemLayout, S: TableHeaderStateType>: TableHeaderFooterConfigType {
	public typealias ViewUpdater = (_ header: TableHeader<ViewType, Layout>, _ state: S) -> Void
	public let state: S?
	let updateView: ViewUpdater?
	
	public init(state: S? = nil, updater: ViewUpdater? = nil) {
		self.state = state
		self.updateView = updater
	}
	
	public func register(with tableView: UITableView) {
		tableView.registerReusableHeaderFooterView(TableHeader<ViewType, Layout>.self)
	}
	
	public func dequeueHeaderFooter(from tableView: UITableView) -> UITableViewHeaderFooterView? {
		let header = tableView.dequeueReusableHeaderFooterView(TableHeader<ViewType, Layout>.self)
		if let updater = updateView, let state = state {
			updater(header, state)
		}
		return header
	}
	
	public var height: CGFloat {
		return state?.height ?? 0
	}
}

public protocol TableHeaderStateType {
	var insets: UIEdgeInsets { get }
	var height: CGFloat { get }
	var topSeparatorHidden: Bool { get }
	var bottomSeparatorHidden: Bool { get }
}

public class TableHeader<ViewType: UIView, Layout: TableItemLayout>: UITableViewHeaderFooterView {
	public let view: ViewType
	public let topSeparator = Separator(style: Separator.Style.full)
	public let bottomSeparator = Separator(style: Separator.Style.full)
	
	public override init(reuseIdentifier: String?) {
		view = ViewType()
		super.init(reuseIdentifier: reuseIdentifier)
		
		contentView.backgroundColor = UIColor.white
		contentView.layoutMargins = view.layoutMargins
		view.layoutMargins = .zero
		contentView.addSubviewsForAutolayout(view)
		
		contentView.addSubviewsForAutolayout(topSeparator, bottomSeparator)
		topSeparator.constrainToTopOfView(contentView)
		bottomSeparator.constrainToBottomOfView(contentView)
		
		Layout.layoutView(view, inContentView: contentView)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

