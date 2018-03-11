## How to update FunctionalTableData from Shopify


1. Copy the FunctionalTableData folder from the original to this demo
    *(Original FTD Repository)[https://github.com/Shopify/FunctionalTableData]

2. For `NibView.swift`. To allow initializing from nib, add this to TableCell and CollectionCell in FunctionalTableData.
```swift
if let nibView = ViewType.self as? NibView.Type, let instance = nibView.instanceFromNib() {
    view = instance as! ViewType
} else {
    view = ViewType()
}
```
