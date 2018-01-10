//
//  TestCellConfig.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-10.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation

class TestCellConfig: CellConfigType {
	var key: String
	
	var style: CellStyle?
	
	var actions: CellActions
	
	init() {
		self.key = "h"
		style = CellStyle()
		actions = CellActions()
	}
	
	func update(cell: UITableViewCell, in tableView: UITableView) {
		// TODO
	}
	
	func register(with tableView: UITableView) {
		// TODO
	}
	
	func update(cell: UICollectionViewCell, in collectionView: UICollectionView) {
		// Purposely left blank
	}
	
	func register(with collectionView: UICollectionView) {
		// Purposely left blank
	}
	
	func isEqual(_ other: CellConfigType) -> Bool {
		return false
	}
	
	func debugInfo() -> [String : Any] {
		return [:]
	}
}
