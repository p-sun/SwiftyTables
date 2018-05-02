//
//  CellStyleViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD040 on 2018-03-11.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import UIKit
import DeclarativeTables

class CellStyleViewController: UIViewController {
    
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    // FTD 1/3 - Init FTD (FunctionalTableData)
    let functionalData = FunctionalTableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.constrainEdges(to: view)
        
        // FTD 2/3 - Let FTD be the delegate and dataSource for this tableView
        functionalData.tableView = tableView
        
        render()
    }

    func render() {
        var rows = [CellConfigType]()

        rows.append(spacerCell(key: "emptyCell0"))
        let fullSeparatorCell = SampleLabelCell(
            key: "fullSeparatorCell",
            style: CellStyle(topSeparator: .full, bottomSeparator: .full, separatorColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
            state: SampleLabelState(text: "Top and bottom separator - .full style"))
        rows.append(fullSeparatorCell)
        
        rows.append(spacerCell(key: "emptyCell1"))
        let insetSeparatorCell = SampleLabelCell(
            key: "inset separrator",
            style: CellStyle(topSeparator: .inset, bottomSeparator: .inset, separatorColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
            state: SampleLabelState(text: "Top and bottom separator - .inset style"))
        rows.append(insetSeparatorCell)
        
        Separator.inset = 15.0 // Globally set the `MoreInset` distance
        rows.append(spacerCell(key: "emptyCell2"))
        let moreInsetSeparatorCell = SampleLabelCell(
            key: "moreInsetSeparatorCell",
            style: CellStyle(topSeparator: .moreInset, bottomSeparator: .moreInset, separatorColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
            state: SampleLabelState(text: "Top and bottom separator - .moreInset style"))
        rows.append(moreInsetSeparatorCell)
        
        rows.append(spacerCell(key: "emptyCell3"))
        let detailAccessoryCell = SampleLabelCell(
            key: "detailAccessoryCell",
            style: CellStyle(accessoryType: .checkmark),
            state: SampleLabelState(text: "Cell can have any UITableViewCellAccessoryType"))
        rows.append(detailAccessoryCell)
        
        let selectionColorCell = SampleLabelCell(
            key: "selectionColorCell",
            style: CellStyle(highlight: true, selectionColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),
            actions: CellActions(selectionAction: { _ in
                return .deselected
            }),
            state: SampleLabelState(text: "Cell is green when selected"))
        rows.append(selectionColorCell)

        let backgroundColorCell = SampleLabelCell(
            key: "backgroundColorCell",
            style: CellStyle(backgroundColor: #colorLiteral(red: 0, green: 0.9410039449, blue: 0.7379586695, alpha: 1)),
            state: SampleLabelState(text: "Cell with a background color"))
        rows.append(backgroundColorCell)
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "colorfulBlur")
        let backgroundViewCell = SampleLabelCell(
            key: "backgroundViewCell",
            style: CellStyle(backgroundView: imageView),
            state: SampleLabelState(text: "Cell with a background view"))
        rows.append(backgroundViewCell)
        
        let tintColorCell = SampleLabelCell(
            key: "tintColorCell",
            style: CellStyle(accessoryType: .checkmark, tintColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
            state: SampleLabelState(text: "Cell with a tint Color"))
        rows.append(tintColorCell)
        
        let extraMarginsCell = SampleLabelCell(
            key: "extraMarginsCell",
            style: CellStyle(backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), layoutMargins: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)),
            state: SampleLabelState(text: "Cell with extra margins of 30 on all sides"))
        rows.append(extraMarginsCell)
        
        // FTD 3/3 - Render Table
        functionalData.renderAndDiff([TableSection(key: "section", rows: rows)])
    }
    
    private func spacerCell(key: String) -> CellConfigType {
        return SpacerCell(key: key, state: SpacerState(height: 20))
    }
}
