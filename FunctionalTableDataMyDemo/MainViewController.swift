//
//  ViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-05.
//  Copyright © 2017 TribalScale. All rights reserved.
//

// TODO
/*
- Create another Carousel cell, using a nib
- collectionHeight
**/

class MainViewController: UIViewController {

	var tableView = UITableView(frame: CGRect.zero, style: .grouped)

	// FTD 1/3 - Init FTD
    let functionalData = FunctionalTableData()

    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(tableView)
		tableView.pinToSuperView()
		
        // FTD 2/3 - Let FTD manage this tableView
        functionalData.tableView = tableView
		
		// FTD 3/3 - Render Table
		render()
    }

    func render() {
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
		
		let carouselDemo = LabelCell(
			key: "carouselDemo",
			style: cellStyleWithDisclosure,
			actions: CellActions(selectionAction: { _ in
				self.show(CarouselViewController(), sender: self)
				return .deselected
			}),
			state: LabelState(text: "CarouselCell Demo"))
		rows.append(carouselDemo)
		
		let detailCell = DetailCell(
			key: "detailCell",
			style: cellStyle,
			actions: CellActions(
				selectionAction: { _ in
					print("Detail Cell Selected")
					return .deselected }
			),
			state: DetailState(
				image: #imageLiteral(resourceName: "finedog"),
				title: "Sample Title",
                subtitle: "This is the subs on a detail cell"))
        rows.append(detailCell)

		let sections = [TableSection(key: "section", rows: rows)]
		functionalData.renderAndDiff(sections)
    }
}
