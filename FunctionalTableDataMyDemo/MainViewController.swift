//
//  ViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD051 on 2017-12-05.
//  Copyright © 2017 TribalScale. All rights reserved.
//

class MainViewController: UIViewController {
    private let functionalData = FunctionalTableData()
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    var randomColors = UIColor.generateRandomData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup tableView
        view.addSubview(tableView)
        tableView.pinToSuperView()
        
        // Setup function table data
        functionalData.tableView = tableView
        render()
    }

    private func render() {
        var rows = [CellConfigType]()
        
        let cellStyle = CellStyle(
            topSeparator: Separator.Style.inset,
            bottomSeparator: Separator.Style.inset,
            separatorColor: .lightGray,
            highlight: true,
            selectionColor: .green,
            backgroundColor: .white)
        
        var cellStyleWithDisclosure = cellStyle
        cellStyleWithDisclosure.accessoryType = .disclosureIndicator
        
        let tableDemo = LabelCell(
            key: "tableDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                self.show(TableViewController(), sender: self)
                return .deselected
            }),
            state: LabelState(text: "UITableView Demo"))
        rows.append(tableDemo)
        
        let collectionDemo = LabelCell(
            key: "collectionDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                let layout = UICollectionViewFlowLayout()
                layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
                self.show(CollectionViewController(collectionViewLayout: layout), sender: self)
                return .deselected
            }),
            state: LabelState(text: "UICollectionView Demo"))
        rows.append(collectionDemo)
        
        let detailCell = DetailCell(
            key: "detailCell",
            style: cellStyle,
            actions: CellActions(selectionAction: { _ in
                print("Detail Cell Selected")
                return .deselected
            }),
            state: DetailState(
                image: #imageLiteral(resourceName: "finedog"),
                title: "Sample Title",
                subtitle: "This is the subs on a detail cell"))
        rows.append(detailCell)

        for (rowIndex, colors) in randomColors.enumerated() {
            let cell = ColorStripCell(
                key: "colorCell\(rowIndex)",
                state: ColorStripState(colors: colors))
            rows.append(cell)
        }
        
        // TODO
        /*
         - Move this to another VC
         - Create another Carousel cell, using a nib
         - Take care of the offset issue with CarouselCells -- make it a CellConfigType instead of a HostCell?
         **/
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
            ])
    }
}

