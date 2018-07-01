//
//  SimplestStaticTableViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD040 on 2018-03-11.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import UIKit
import SwiftyTables

class SimplestStaticTableViewController: UIViewController {
    
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
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
                
        let topHatCell = SampleNibCell(
            key: "topHatCell",
            state: SampleNibState(image: #imageLiteral(resourceName: "topHatEmoji"), title: "<-- A custom detail cell", subtitle: ""))

        let happyCell = SampleLabelCell(
            key: "happyCell",
            state: SampleLabelState(text: "😃 <-- A custom label cell"))

        let heartCell = SampleLabelCell(
            key: "heartCell",
            state: SampleLabelState(text: "😍 Re-ordering cells is easy, even if the cells are different types. Try reordering the `rows` variable."))

        let fireCell = SampleLabelCell(
            key: "fireCell",
            state: SampleLabelState(text: "🔥 A properly constrained cell will resize to hug its contents. Try rotating the device."))

        // FTD 3/3 - Render Table
        // In renderAndDiff, the parameter are structs representing ALL the sections and cells in this tableView.
        // * We pass it an array of `TableSection`s.
        // * Each `TableSection` has an array of `CellConfigType`.
        // * Each `CellConfigType` displays a row in the tableView.
        let rows: [CellConfigType] = [topHatCell, happyCell, heartCell, fireCell]
        functionalData.renderAndDiff([TableSection(key: "section", rows: rows)])
    }
}
