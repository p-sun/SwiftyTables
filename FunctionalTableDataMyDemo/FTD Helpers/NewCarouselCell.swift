////
////  CarouselCell.swift
////  FunctionalTableDataMyDemo
////
////  Created by TSD051 on 2018-01-16.
////  Copyright © 2018 TribalScale. All rights reserved.
////
//
//import Foundation
//
class CarouselCell<T: CarouselItemCell>: CellConfigType {
    var key: String
    var style: CellStyle?
    var actions: CellActions
    private var state: CarouselState<T>
    
    private typealias TableViewCellType = TableCell<CarouselView<T>, EdgeBasedTableItemLayout>
    
    private var tableLayoutMargins = UIEdgeInsets.zero

    init(key: String, style: CellStyle? = nil, state: CarouselState<T>, actions: CellActions = CellActions()) {
        self.key = key
        self.style = style
        self.state = state
        self.actions = actions
    }

    func register(with tableView: UITableView) {
        tableLayoutMargins = tableView.layoutMargins
        tableView.registerReusableCell(TableViewCellType.self)
    }
    
    public func dequeueCell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TableViewCellType.self, indexPath: indexPath)
        
        // Prepare for reuse if needed
        // CarouselState<T>.updateView(cell.view, state: nil)
        
        return cell
    }
    
    func update(cell: UITableViewCell, in tableView: UITableView) {
        guard let carouselCell = cell as? TableViewCellType else { return }
        
        carouselCell.view.setContentInset(tableLayoutMargins)
        CarouselState<T>.updateView(carouselCell.view, state: state)
        
        // Only layout cells that aren't in the reuse pool
        if cell.superview != nil && !cell.isHidden {
            UIView.performWithoutAnimation {
                cell.layoutIfNeeded()
            }
        }
    }
    
    func isEqual(_ other: CellConfigType) -> Bool {
        if let other = other as? CarouselCell<T> {
            return state == other.state
        }
        return false
    }
    
    func debugInfo() -> [String : Any] {
        return [:]
    }
    
    func register(with collectionView: UICollectionView) {
        // Not applicable -- no reason to have a collectionView in a collectionView
    }
    
    func update(cell: UICollectionViewCell, in collectionView: UICollectionView) {
        // Not applicable -- no reason to have a collectionView in a collectionView
    }
}

