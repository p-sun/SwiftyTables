//
//  ColorTilesViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by Pei Sun on 2018-01-06.
//

import UIKit

class ColorTilesViewController: UIViewController {
	var tableView = UITableView(frame: CGRect.zero, style: .grouped)

	// FTD 1/3 - Init FTD
	let functionalData = FunctionalTableData()
	
	// Data for cells
	let randomColors: [[UIColor]]
	var storedOffsets: [CGFloat]

	init() {
		randomColors = UIColor.generateRandomData()
		storedOffsets = Array(repeatElement(0, count: randomColors.count))
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "CarouselCell Demo"
		view.addSubview(tableView)
		tableView.pinToSuperView()
		
		// FTD 2/3 - Set tableview
		functionalData.tableView = tableView
		
		// FTD 3/3 - Render Table Sections
		render()
	}

	func render() {
		var rows = [CellConfigType]()

		for (rowIndex, colors) in randomColors.enumerated() {
			let cell = CarouselColorTilesCell(
				key: "colorCell\(rowIndex)",
				actions: CellActions(
					visibilityAction: { [weak self] cellView, visible in
						guard let strongSelf = self else { return }
						if let CarouselView = cellView.subviews.first?.subviews.first as? CarouselView<CarouselItemColorTilesCell> {
							if visible {
								CarouselView.carouselOffset = strongSelf.storedOffsets[rowIndex]
							} else {
								strongSelf.storedOffsets[rowIndex] = CarouselView.carouselOffset
							}
						}
					}
				),
				state: CarouselState<CarouselItemColorTilesCell>(
					itemModels: colors,
					didSelectCell: { indexPath in
						print("Did tap item \(indexPath.row)")},
					collectionHeight: 120)
			)
			rows.append(cell)
		}
		
		let sections = [TableSection(key: "section", rows: rows)]
		functionalData.renderAndDiff(sections)
	}
}
