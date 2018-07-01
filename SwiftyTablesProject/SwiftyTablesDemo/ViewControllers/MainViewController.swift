//
//  ViewController.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-05.
//

import UIKit
import SwiftyTables

class MainViewController: UIViewController {

	var tableView = UITableView(frame: CGRect.zero, style: .grouped)

	// FTD 1/3 - Init FTD
    let functionalData = FunctionalTableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(tableView)
        tableView.constrainEdges(to: view)
		
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
            backgroundColor: .white)

        var cellStyleWithDisclosure = cellStyle
        cellStyleWithDisclosure.accessoryType = .disclosureIndicator

        let staticTableDemo = SampleLabelCell(
            key: "staticTableDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                let vc = SimplestStaticTableViewController()
                vc.navigationItem.title = "🔮 1. Build a simple table"
                self.show(vc, sender: self)
                return .deselected
            }),
            state: SampleLabelState(text: "🔮 1. Build a simple table"))
        rows.append(staticTableDemo)
        
        let dynamicTableDemo = SampleLabelCell(
            key: "dynamicTableDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                let vc = SimplestDynamicTableViewController()
                vc.navigationItem.title = "🍏 2. Build a table from a dataset"
                self.show(vc, sender: self)
                return .deselected
            }),
            state: SampleLabelState(text: "🍏 2. Build a table from a dataset"))
        rows.append(dynamicTableDemo)
        
        let styleDemo = SampleLabelCell(
            key: "styleDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                let vc = CellStyleViewController()
                vc.navigationItem.title = "🌼 3. Add flair with CellStyle"
                self.show(vc, sender: self)
                return .deselected
            }),
            state: SampleLabelState(text: "🌼 3. Add flair with CellStyle"))
        rows.append(styleDemo)
        
        let tableDemo = SampleLabelCell(
            key: "tableDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                self.show(TableViewController(), sender: self)
                return .deselected
            }),
            state: SampleLabelState(text: "UITableView Demo"))
        rows.append(tableDemo)

        let collectionDemo = SampleLabelCell(
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
            state: SampleLabelState(text: "UICollectionView Demo"))
        rows.append(collectionDemo)
//
        let colorTilesDemo = SampleLabelCell(
            key: "colorTilesDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                self.show(ColorTilesViewController(), sender: self)
                return .deselected
            }),
            state: SampleLabelState(text: "Horizontal CarouselCell Demo"))
        rows.append(colorTilesDemo)

        let carouselVerticalGridDemo = SampleLabelCell(
            key: "carouselVerticalGridDemo",
            style: cellStyleWithDisclosure,
            actions: CellActions(selectionAction: { _ in
                self.show(VerticalGridCellViewController(), sender: self)
                return .deselected
            }),
            state: SampleLabelState(text: "Vertical CarouseCell Demo"))
        rows.append(carouselVerticalGridDemo)

        let labelCell = SampleLabelCell(
            key: "labelCell",
            style: cellStyle,
            actions: CellActions(selectionAction: { _ in
                print("label cell tapped")
                return .deselected
            }),
            state: SampleLabelState(text: "LabelCell"))
        rows.append(labelCell)

//        let buttonCell = ButtonCell(
//            key: "buttonCell",
//            state: ButtonState(title: "",
//                               action: {
//                print("button switched")
//            }))
//        rows.append(buttonCell)

        let detailCell = SampleNibCell(
            key: "detailCell",
            style: cellStyle,
            actions: CellActions(
                selectionAction: { _ in
                    print("Detail Cell Selected")
                    return .deselected }
            ),
            state: SampleNibState(
                image: #imageLiteral(resourceName: "finedog"),
                title: "Cell created from nib",
                subtitle: "subtitles"))
        rows.append(detailCell)

        let defaultDetailCell = DefaultDetailCell(
            key: "defaultDetailCell",
            style: cellStyle,
            actions: CellActions(
                selectionAction: { _ in
                    print("Detail Cell Selected")
                    return .deselected }
            ),
            state: DefaultDetailState(
                image: #imageLiteral(resourceName: "finedog"),
                title: "DetailCell -- created Programically",
                subtitle: "subtitle"))
        rows.append(defaultDetailCell)

        let dogeItemState = CarouselItemDetailState(image: #imageLiteral(resourceName: "finedog"), title: "Doge", subtitle: "This is fine")
        let dogeCarousel = CarouselDetailCell(
            key: "dogeCarousel",
            state: CarouselState<CarouselItemDetailCell>(
                itemModels: Array(repeating: dogeItemState, count: 20),
                collectionHeight: 200,
                didSelectItemCell: { index in
                    print("Did select doge at index \(index)") }))
        rows.append(dogeCarousel)

        let colorTilesCell = CarouselColorTilesCell(
            key: "colorTilesCell",
            state: CarouselState<CarouselItemColorTilesCell>(
                itemModels: [.red, .blue, .purple, .yellow, .green, .orange],
                collectionHeight: 120,
                didSelectItemCell: { indexPath in
                    print("Did tap item \(indexPath.row)")})
        )
        rows.append(colorTilesCell)
		
		let sections = [TableSection(key: "section", rows: rows)]
		functionalData.renderAndDiff(sections)
    }
}
