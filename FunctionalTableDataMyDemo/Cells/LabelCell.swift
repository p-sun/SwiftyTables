import UIKit

typealias LabelCell = HostCell<UILabel, LabelState, LayoutMarginsTableItemLayout>

/// A very simple state for a `UILabel` allowing a quick configuration of its text, font, and color values.
struct LabelState {
	let text: String
	let font: UIFont
	let color: UIColor
	
	init(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = .black) {
		self.text = text
		self.font = font
		self.color = color
	}
}

extension LabelState: StateType {
    typealias View = UILabel

    /// Update the view with the contents of the state.
    ///
    /// - Parameters:
    ///   - view: `UIView` that responds to this state.
    ///   - state: data to update the view with. If `nil` the view is being reused by the tableview.
    static func updateView(_ view: UILabel, state: LabelState?) {
        guard let state = state else {
            view.text = nil
            view.font = UIFont.systemFont(ofSize: 17)
            view.textColor = .black
            return
        }
        
        view.text = state.text
        view.font = state.font
        view.textColor = state.color
    }
}

extension LabelState: Equatable {
	static func ==(lhs: LabelState, rhs: LabelState) -> Bool {
		return lhs.text == rhs.text && lhs.font == rhs.font && lhs.color == rhs.color
	}
}
