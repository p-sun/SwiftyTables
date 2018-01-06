//
//  ViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD051 on 2017-12-05.
//  Copyright © 2017 TribalScale. All rights reserved.
//

class MainViewController: UIViewController {
	
	// FTD 1/3 - Init FTD
    private let functionalData = FunctionalTableData()
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)

	// Data for Carousels
	let randomColors: [[UIColor]]
	var storedOffsets: [CGFloat]
	
	required init?(coder aDecoder: NSCoder) {
		randomColors = UIColor.generateRandomData()
		storedOffsets = Array(repeatElement(0, count: randomColors.count))

		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // FTD 2/3 - Set tableview
		view.addSubview(tableView)
		tableView.pinToSuperView()
        functionalData.tableView = tableView
		
		// FTD 3/3 - Render Table Sections
		functionalData.renderAndDiff(sections())
    }

    private func sections() -> [TableSection] {
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

        for (rowIndex, colors) in randomColors.enumerated() {
            let cell = ColorStripCell(
                key: "colorCell\(rowIndex)",
				actions: CellActions(
					visibilityAction: { [weak self] cellView, visible in
						guard let strongSelf = self else { return }
						if let carouselCell = cellView.subviews.first?.subviews.first as? CarouselCell<ColorStripItemCell> {
							if visible {
								carouselCell.carouselOffset = strongSelf.storedOffsets[rowIndex]
							} else {
								strongSelf.storedOffsets[rowIndex] = carouselCell.carouselOffset
							}
						}
					}
				),
                state: ColorStripState(colors: colors))
            rows.append(cell)
        }
        
        // TODO
        /*
         - Move this to another VC
         - Create another Carousel cell, using a nib
         **/

		return [TableSection(key: "section", rows: rows)]
    }
}
