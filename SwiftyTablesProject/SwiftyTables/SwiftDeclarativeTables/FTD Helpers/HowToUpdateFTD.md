## How to update FunctionalTableData from Shopify


1. Copy the FunctionalTableData folder from the original to this demo
    *(Original FTD Repository)[https://github.com/Shopify/FunctionalTableData]

2. For `NibView.swift`. To allow initializing from nib, replace all instances of `view = ViewType()` with the following. i.e. in `TableCell` ,  `CollectionCell`, and `TableHeaderFooter` in FunctionalTableData.
```swift
if let nibView = ViewType.self as? NibView.Type, let instance = nibView.instanceFromNib() {
    view = instance as! ViewType
} else {
    view = ViewType()
}
```

3. In `CellStyle`, replace
```
cell.layer.cornerRadius = cornerRadius
cell.layer.masksToBounds = true
```
with
```swift
if cornerRadius > 0 {
    cell.layer.cornerRadius = cornerRadius
    cell.layer.masksToBounds = true
} else {
    cell.layer.masksToBounds = false
}
```

4. Reset `FunctionalTableData` to implement the `estimatedHeightForHeaderInSection` and `estimatedHeightForFooterInSection` methods.
```
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
return tableViewStyle == .grouped ? CGFloat.leastNormalMagnitude : 0
}
return header.height
}

private func heightForFooterInSection(tableViewStyle: UITableViewStyle, section: Int) -> CGFloat {
guard let footer = sections[section].footer else {
// When given a height of zero grouped style UITableView's use their default value instead of zero. By returning CGFloat.min we get around this behavior and force UITableView to end up using a height of zero after all.
return tableViewStyle == .grouped ? CGFloat.leastNormalMagnitude : 0
}
return footer.height
}
```

5. Implement  `estimatedHeightForRowAt` in `FunctionalTableData`.
```
public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if let indexKeyPath = sections[indexPath.section].sectionKeyPathForRow(indexPath.row) {
        return heightAtIndexKeyPath[indexKeyPath] ?? UITableViewAutomaticDimension
    } else {
        return UITableViewAutomaticDimension
    }
}
```

6. Replace `if #available(iOSApplicationExtension 11.0` with `if #available(iOS 11.0`

7. Copy and paste the contents of `FunctionalTableData.h` from the Shopify repo into `SwiftyTables.h` this repo.
