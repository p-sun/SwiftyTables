//
//  SimplestViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD040 on 2018-03-11.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import UIKit
import DeclarativeTables

class SimplestDynamicTableViewController: UIViewController {
    
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    let items = ["Apples", "Bananas", "Cranberries", "Dragonfruit", "Elderberry", "Fig"]
    
    // FTD 1/3 - Init FTD (FunctionalTableData)
    let functionalData = FunctionalTableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Constrain the tableView
        view.addSubview(tableView)
        tableView.constrainEdges(to: view)
        
        // FTD 2/3 - Let FTD be the delegate and dataSource for this tableView
        functionalData.tableView = tableView
        
        render()
    }

    func render() {
        // Create rows of FTD cells
        var rows = [CellConfigType]()
        for (index, item) in items.enumerated() {
            rows.append(
                SampleLabelCell(key: "\(index)", state: SampleLabelState(text: item))
            )
        }
        
        // FTD 3/3 - Render Table
        functionalData.renderAndDiff([TableSection(key: "section", rows: rows)])
    }
}
