# Swift-Declarative-Tables
Makes Swift 4 tables much simpler and declarative, like React, making it simple to add and remove sections and rows dynamically.

No more crazy switches and monster UITableViewDelegates methods! Each cell's state is declared in one place.

Forked off of [Shopify's FunctionalTableData](https://github.com/Shopify/FunctionalTableData). 

I've added more examples and now allow creating new cells using Nibs -- simply conform any `UIView` to `NibView`, and pass into a `HostCell`.
