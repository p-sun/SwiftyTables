# Swift-Declarative-Tables
Makes Swift 4 tables much simpler and declarative, like React, making it simple to add and remove sections and rows dynamically.

No more crazy switches and monster UITableViewDelegates methods! Each cell's state is declared in one place.

Forked off of [Shopify's FunctionalTableData](https://github.com/Shopify/FunctionalTableData). 

I've added the following,
🌟 A easy to use generic `CarouselCell` that it is a `CellConfigType` (i.e. a FunctionalTableData cell), containing a `UICollectionView` with a single type of `UICollectionViewCell`.
🌟 Sample cells and view controllers demonstrating how to use FunctionalTableData.
🌟 Custom cells, headers, and `CarouselItemCells` created can be created programically or with nibs. Simply conform the UIVIew/UICollectionViewCell to the protocol `NibView`/`CarouselItemNibView`.

## TableView Jumps when it is scrolled 🐛
### How to Replicate 🐛 
1. Comment out 'estimatedHeightForHeaderInSection' and `estimatedHeightForFooterInSection` in `FunctionalTableData`.
2. Open the app, tap `Table Sections Demo`.
3. Scroll down the table.
4. Tap a cell to re-render the table.
5. Scroll up. The table will jump when a new TableSection is displayed.

![Header Height Bug][buggif]

### Solution
The tableView jumps because `estimatedHeightForHeaderInSection` and `estimatedHeightForFooterInSection` have not been implemented in `FunctionalTableData`.
This implementation fixes the issue.

```swift
public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return heightForHeaderInSection(tableViewStyle: tableView.style, section: section)
}

public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
    return heightForFooterInSection(tableViewStyle: tableView.style, section: section)
}

public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return heightForHeaderInSection(tableViewStyle: tableView.style, section: section)
}

public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return heightForFooterInSection(tableViewStyle: tableView.style, section: section)
}

private func heightForHeaderInSection(tableViewStyle: UITableViewStyle, section: Int) -> CGFloat {
    guard let header = sections[section].header else {
        // When given a height of zero grouped style UITableView's use their default value instead of zero. By returning CGFloat.min we get around this behavior and force UITableView to end up using a height of zero after all.
        return tableViewStyle == .grouped ? minimumHeaderHeight : 0
    }
    return header.height
}

private func heightForFooterInSection(tableViewStyle: UITableViewStyle, section: Int) -> CGFloat {
    guard let footer = sections[section].footer else {
        // When given a height of zero grouped style UITableView's use their default value instead of zero. By returning CGFloat.min we get around this behavior and force UITableView to end up using a height of zero after all.
        return tableViewStyle == .grouped ? minimumHeaderHeight : 0
    }
    return footer.height
}

private var minimumHeaderHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return CGFloat.leastNormalMagnitude
    } else {
        return 2.0
    }
}
```

## 🌟 This Demo 🌟 

### MainViewController
FunctionalTableData demo with multiple types of cells.

### TableViewController
FunctionalTableData demo where cells can be inserted and removed when you tap ➕ or 🗑.

### CollectionViewController
CollectionTableData demo where cells can be inserted and removed when you tap ➕ or 🗑.

### CarouselCell\<CustomItemCell\>
A generic FunctionalTableData cell with a horizontal scrolling, or vertical non-scrolling `UICollectionView`.
Each `CarouselCell` takes a single `CarouselItemCell` type.
Each `CarouselItemCell` is a `UICollectionViewCell`, and is associated with a `ItemModel` type that it uses to calculate its size, and configure its views.


```swift
protocol CarouselItemCell where Self: UICollectionViewCell {
	associatedtype ItemModel: Equatable'
	
	static func sizeForItem(model: ItemModel, in collectionView: UICollectionView) -> CGSize
	func configure(model: ItemModel)
	
	static func scrollDirection() -> UICollectionViewScrollDirection
}
```

##### CarouselCell\<CarouselItemColorTilesCell\>
A programically created scrolling horizontal CarouselCell.
The `ItemModel` is a `UIColor`, which sets the `CarouselItemColorTilesCell`'s color.

```swift
let cell = CarouselColorTilesCell(
	key: "colorTilesCell",
	state: CarouselState<CarouselItemColorTilesCell>(
		itemModels: [.red, .blue, .purple, .yellow, .green, .orange],
		collectionHeight: 120,
		didSelectItemCell: { indexPath in
			print("Did tap item \(indexPath.row)")})
)
```

![Color Tiles CarouselCell][colorTilesGif]

##### CarouselCell\<CarouselItemVerticalGridCell\>
A programically created non-scrolling vertical CarouselCell.

```swift
let fourGridCell = resizableCell(key: "fourGridCell", color: .purple, height: 100, itemsPerRow: [1, 3])

let fiveGridCell = resizableCell(key: "fiveGridCell", color: .green, height: 100, itemsPerRow: [2, 3])

let tenGridCell = resizableCell(key: "tenGridCell", color: .blue, height: 100, itemsPerRow: [4, 3, 2, 1])
```

![Vertical Grid Cell][verticalCarousel]


##### CarouselCell - CarouselCell\<CarouselItemDetailCell\>
A scrolling horizontal CarouselCell created using a storyboard.

```swift
let dogeItemState = CarouselItemDetailState(image: #imageLiteral(resourceName: "finedog"), title: "Doge", subtitle: "This is fine")
let dogeCarousel = CarouselDetailCell(
	key: "dogeCarousel",
	state: CarouselState<CarouselItemDetailCell>(
		itemModels: Array(repeating: dogeItemState, count: 20),
		collectionHeight: 220,
		didSelectItemCell: { index in
			print("Did select doge at index \(index)") }))
```

![CarouselDetailCell][dogegif]

#### DetailCell
A `CellConfigType` created with storyboard.

```swift
let detailCell = DetailCell(
	key: "detailCell",
	state: DetailState(
		image: #imageLiteral(resourceName: "finedog"),
		title: "Sample Title",
		subtitle: "This is the subs on a detail cell"))
```

![LabelCell][detailCell]


#### LabelCell
A programically created `CellConfigType`.

```swift
let labelCell = LabelCell(
	key: "labelCell",
	actions: CellActions(selectionAction: { _ in
		print("label cell tapped")
		return .deselected
	}),
	state: LabelState(text: "This is a LabelCell"))

```

![LabelCell][labelCell]


[buggif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/master/Images/Issue.gif
[colorTilesGif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/master/Images/ColorTilesCarouselCell.gif
[dogegif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/master/Images/DogeCell.gif
[verticalCarousel]: https://github.com/p-sun/Swift-Declarative-Tables/blob/master/Images/VerticalCarousel.png
[labelCell]: https://github.com/p-sun/Swift-Declarative-Tables/blob/master/Images/LabelCell.png
[detailCell]: https://github.com/p-sun/Swift-Declarative-Tables/blob/master/Images/DetailCell.png
