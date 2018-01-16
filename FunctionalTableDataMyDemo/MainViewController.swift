//
//  ViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-05.
//

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
				if #available(iOS 10.0, *) {
					layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
				} else {
					layout.estimatedItemSize = CGSize(width: 1, height: 1)
				}
                self.show(CollectionViewController(collectionViewLayout: layout), sender: self)
                return .deselected
            }),
            state: LabelState(text: "UICollectionView Demo"))
        rows.append(collectionDemo)
		
		let carouselDemo = LabelCell(
			key: "carouselDemo",
			style: cellStyleWithDisclosure,
			actions: CellActions(selectionAction: { _ in
				self.show(ColorTilesViewController(), sender: self)
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
		
        let itemState = CarouselItemDetailState(image: #imageLiteral(resourceName: "finedog"), title: "Doge", subtitle: "This is fine")
        let dogeCarouselView = CarouselDetailCell(
            key: "dogeCell",
            state: CarouselState<CarouselItemDetailCell>(
				itemModels: Array(repeating: itemState, count: 4),
                didSelectCell: { (_) in
                    print("did select doge") },
				spacing: 15))
        rows.append(dogeCarouselView)

		let header = SimpleHeaderConfig("title")
		let sections = [TableSection(key: "section", rows: rows, header: header)]
		functionalData.renderAndDiff(sections)
    }
}
