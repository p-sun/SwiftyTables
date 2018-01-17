//
//  DetailCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-19.
//

import Foundation

typealias DetailCell = HostCell<DetailView, DetailState, LayoutMarginsTableItemLayout>

class DetailView: UIView, NibView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = .blue
    }
}

struct DetailState {
    let image: UIImage?
    let title: String
    let subtitle: String
    
    init(image: UIImage? = nil, title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

extension DetailState: StateType {
    typealias View = DetailView

    static func updateView(_ view: DetailView, state: DetailState?) {
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

extension DetailState: Equatable {
    static func ==(lhs: DetailState, rhs: DetailState) -> Bool {
        var equality = lhs.title == rhs.title
        equality = equality && lhs.subtitle == rhs.subtitle
        equality = equality && lhs.image == rhs.image
        return equality
    }
}
