# Swift-Declarative-Tables
Makes Swift 4 tables much simpler and declarative, like React, making it simple to add and remove sections and rows dynamically.

No more crazy switches and monster UITableViewDelegates methods! Each cell's state is declared in one place.

Forked off of [Shopify's FunctionalTableData](https://github.com/Shopify/FunctionalTableData). 

I've added more examples and now allow creating new cells using Nibs -- simply conform any `UIView` to `NibView`, and pass into a `HostCell`.

## TableView Jumps when it is scrolled 🐛
### 🐛 Replication -- Setup
1. Create a custom `CellConfigType` cell with a height that's not the default height of 44.
2. Make an array of 30 `TableSection`s, where each `TableSection` contains this custom cell.
3. In the cell's `selectionAction`, re-render the table, making sure the cell's state change when it's re-rendered.

This bug has been replicated in `TableSectionsViewController` in this repo. Here, I'm adding a 🐒 emoji to the cell's titleLabel when the cell is tapped.

### 🐛 Replication -- Execution
1. Scroll down the table.
2. Tap a cell to re-render the table.
3. Scroll up. Then the table will jump.

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
		// When given a height of zero grouped style UITableView’s use their default value instead of zero. By returning CGFloat.min we get around this behavior and force UITableView to end up using a height of zero after all.
		return tableViewStyle == .grouped ? CGFloat.leastNormalMagnitude : 0
	}
	return header.height
}

private func heightForFooterInSection(tableViewStyle: UITableViewStyle, section: Int) -> CGFloat {
	guard let footer = sections[section].footer else {
		// When given a height of zero grouped style UITableView’s use their default value instead of zero. By returning CGFloat.min we get around this behavior and force UITableView to end up using a height of zero after all.
		return tableViewStyle == .grouped ? CGFloat.leastNormalMagnitude : 0
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

## Features of this Demo 🌟 
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

##### CarouselCell - CarouselCell\<CarouselItemColorTilesCell\>
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

##### CarouselCell - CarouselCell\<CarouselItemVerticalGridCell\>
A programically created non-scrolling vertical CarouselCell.

```swift
let fourGridCell = resizableCell(key: "fourGridCell", color: .purple, height: 100, itemsPerRow: [1, 3])
rows.append(fourGridCell)

let fiveGridCell = resizableCell(key: "fiveGridCell", color: .green, height: 100, itemsPerRow: [2, 3])
rows.append(fiveGridCell)

let tenGridCell = resizableCell(key: "tenGridCell", color: .blue, height: 100, itemsPerRow: [4, 3, 2, 1])
rows.append(tenGridCell)

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

#### LabelCell
A programically created `CellConfigType`.


[buggif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/table_skipping_issue/Images/Issue.gif ""
[colorTilesGif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/table_skipping_issue/Images/ColorTilesCarouselCell.gif ""
[dogegif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/table_skipping_issue/Images/DogeCell.gif ""
[verticalCarousel]: https://github.com/p-sun/Swift-Declarative-Tables/blob/table_skipping_issue/Images/VerticalCarousel.png ""
