//
//  DetailCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-19.
//

import SwiftyTables

typealias SampleNibCell = HostCell<SampleNibView, SampleNibState, LayoutMarginsTableItemLayout>

class SampleNibView: UIView, NibView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Can setup the views here
    }
}

struct SampleNibState {
    let image: UIImage?
    let title: String
    let subtitle: String
    
    init(image: UIImage? = nil, title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

extension SampleNibState: StateType {
    typealias View = SampleNibView

    static func updateView(_ view: SampleNibView, state: SampleNibState?) {
        guard let state = state else {
            view.imageView.image = nil
            view.titleLabel.text = nil
            view.subtitleLabel.text = nil
            return
        }
        
        view.imageView.image = state.image
        view.titleLabel.text = state.title
        view.subtitleLabel.text = state.subtitle
    }
}

extension SampleNibState: Equatable {
    static func ==(lhs: SampleNibState, rhs: SampleNibState) -> Bool {
        var equality = lhs.title == rhs.title
        equality = equality && lhs.subtitle == rhs.subtitle
        equality = equality && lhs.image == rhs.image
        return equality
    }
}
