//
//  DetailCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD051 on 2017-12-19.
//  Copyright © 2017 TribalScale. All rights reserved.
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

struct DetailState: Equatable {
    let image: UIImage?
    let title: String
    let subtitle: String
    
    init(image: UIImage? = nil, title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
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
    
    static func ==(lhs: DetailState, rhs: DetailState) -> Bool {
        return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.image == rhs.image
    }
}
