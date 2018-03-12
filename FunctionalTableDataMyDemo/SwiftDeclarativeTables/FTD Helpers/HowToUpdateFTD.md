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
3. Reset FunctionalTableData to implement the `estimatedHeightForHeaderInSection` and `estimatedHeightForFooterInSection` methods.

4. Add this to 
```swift
if cornerRadius > 0 {
    cell.layer.cornerRadius = cornerRadius
    cell.layer.masksToBounds = true
} else {
    cell.layer.masksToBounds = false
}
```
