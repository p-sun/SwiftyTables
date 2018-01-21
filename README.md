# Swift-Declarative-Tables
Makes Swift 4 tables much simpler and declarative, like React, making it simple to add and remove sections and rows dynamically.

No more crazy switches and monster UITableViewDelegates methods! Each cell's state is declared in one place.

Forked off of [Shopify's FunctionalTableData](https://github.com/Shopify/FunctionalTableData). 

I've added more examples and now allow creating new cells using Nibs -- simply conform any `UIView` to `NibView`, and pass into a `HostCell`.

## Table Scroll Skipping 🐛
### 🐛 Replication -- Setup
1. Create a custom `CellConfigType` cell with a height that's not the default height of 44.
2. Make an array of 30 `TableSection`s, where each `TableSection` contains this custom cell.
3. In the cell's `selectionAction`, re-render the table.

This bug has been replicated in `TableSectionsViewController` in this repo.

### 🐛 Replication -- Execution
1. Scroll down the table.
2. Tap a cell to re-render the table.
3. Scroll up. Then the table will skip.

![Header Height Bug][buggif]

[buggif]: https://github.com/p-sun/Swift-Declarative-Tables/blob/table_skipping_issue/Issue.gif ""

### Solution
The tableView jumps because `estimatedHeightForHeaderInSection` and `estimatedHeightForFooterInSection` have not been implemented in `FunctionalTableData`. Simply return the contents of `heightForHeaderInSection` and `heightForFooterInSection` to fix the bug.
