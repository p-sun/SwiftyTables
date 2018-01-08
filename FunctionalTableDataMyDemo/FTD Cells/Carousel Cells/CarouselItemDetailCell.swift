//
//  CarouselItemDetailCell.swift
//  Collection View in a Table View Cell
//
//  Created by Paige Sun on 2017-12-12.
//

import UIKit

class CarouselItemDetailCell: UICollectionViewCell, CarouselItemCell, CarouselItemNibView {
	
	typealias Model = CarouselItemDetails
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	private static let size = CGSize(width: 200, height: 158)

	static func sizeForItem(model: Model) -> CGSize {
		return CarouselItemDetailCell.size
	}
	
	func configure(model: CarouselItemDetails) {
		self.imageView.image = model.image
		self.titleLabel.text = model.title
		self.subtitleLabel.text = model.subtitle
	}
}

struct CarouselItemDetails {
    let image: UIImage?
    let title: String?
    let subtitle: String?
    
    init(image: UIImage?, title: String?, subtitle: String?) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}

extension CarouselItemDetails: Equatable {
    static func ==(lhs: CarouselItemDetails, rhs: CarouselItemDetails) -> Bool {
        return lhs.image == rhs.image
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
    }
}
