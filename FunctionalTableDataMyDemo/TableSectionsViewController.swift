//
//  TableSectionsViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-21.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

class TableSectionsViewController: UIViewController {
	
	var tableView = UITableView(frame: CGRect.zero, style: .grouped)
	
	var displayMonkey = false
	
	// FTD 1/3 - Init FTD
	let functionalData = FunctionalTableData()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubviewsForAutolayout(tableView)
		tableView.constrainToFillView(view)
		
		// FTD 2/3 - Let FTD manage this tableView
		functionalData.tableView = tableView
		
		// FTD 3/3 - Render Table
		render()
	}
	
	@objc func render() {
		var sections = [TableSection]()
		
		var title = "Scroll down a page, tap a cell, then scroll up. The table will skip."
		if displayMonkey {
			title += "🐒"
		}
		displayMonkey = !displayMonkey
		
		for i in 0..<30 {

			let cell = ProgramicDetailCell(
				key: "programicDetailCell",
				actions: CellActions(selectionAction: { [weak self] _ in
					self?.render()
					return .deselected
				}),
				state: ProgramicDetailState(title: title))
			
			
			let section = TableSection(key: "section\(i)", rows: [cell])
			
			sections.append(section)
		}

		functionalData.renderAndDiff(sections)
	}
}
