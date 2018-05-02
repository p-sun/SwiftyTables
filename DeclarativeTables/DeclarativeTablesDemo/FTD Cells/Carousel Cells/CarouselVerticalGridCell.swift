//
//  CarouselVerticalGridCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2018-01-17.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import UIKit
import DeclarativeTables

typealias CarouselVerticalGridCell = CarouselCell<CarouselItemVerticalGridCell>

class CarouselItemVerticalGridCell: UICollectionViewCell, CarouselItemCell {
	
	typealias ItemModel = CarouselItemVerticalGridState
	
    private let colorView = UIView()
	
	var size = CGSize.zero
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(colorView)
        colorView.constrainEdges(to: contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func sizeForItem(model: ItemModel, in collectionView: UICollectionView) -> CGSize {
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		
		let totalWidth = collectionView.bounds.size.width
		let contentInset = collectionView.contentInset
		let widthMinusInsets = totalWidth - contentInset.left - contentInset.right
		let widthMinusSpacing = widthMinusInsets - (model.itemsInThisRow - 1) * layout.minimumLineSpacing
		let widthForItem = widthMinusSpacing / model.itemsInThisRow
        return CGSize(width: widthForItem, height: model.height)
    }
	
	static func scrollDirection() -> UICollectionViewScrollDirection {
		return .vertical
	}
	
    func configure(model: ItemModel) {
		self.colorView.backgroundColor = model.color.withAlphaComponent(0.6)
		self.colorView.addDiagonalShading(size: self.bounds, index: self.tag)
    }
}

struct CarouselItemVerticalGridState {
	let color: UIColor
	let height: CGFloat
	let itemsInThisRow: CGFloat
	
	init(color: UIColor, height: CGFloat, itemsInThisRow: CGFloat) {
		assert(itemsInThisRow > 0)
		self.color = color
		self.height = height
		self.itemsInThisRow = itemsInThisRow
	}
}

extension CarouselItemVerticalGridState: Equatable {
	static func ==(lhs: CarouselItemVerticalGridState, rhs: CarouselItemVerticalGridState) -> Bool {
		var equality = lhs.color == rhs.color
		equality = equality && lhs.height == rhs.height
		equality = equality && lhs.itemsInThisRow == rhs.itemsInThisRow
		return equality
	}
}

private extension UIView {
	func addDiagonalShading(size: CGRect, index: Int) {
		struct GradientColors {
			private static let topColors = [#colorLiteral(red: 0.4, green: 0.3490196078, blue: 0.007843137255, alpha: 1), #colorLiteral(red: 0.4, green: 0.007843137255, blue: 0.3490196078, alpha: 1), #colorLiteral(red: 0.4, green: 0.007843137255, blue: 0.007843137255, alpha: 1), #colorLiteral(red: 0.05490196078, green: 0.4, blue: 0.007843137255, alpha: 1), #colorLiteral(red: 0.5882352941, green: 0.3607843137, blue: 0, alpha: 1), #colorLiteral(red: 0.007843137255, green: 0.07058823529, blue: 0.4, alpha: 1), #colorLiteral(red: 0.4, green: 0, blue: 0.3504559801, alpha: 1), #colorLiteral(red: 0.4, green: 0.2038615125, blue: 0, alpha: 1), #colorLiteral(red: 0.2074886848, green: 0, blue: 0.4, alpha: 1), #colorLiteral(red: 0, green: 0.4, blue: 0.1079017388, alpha: 1), #colorLiteral(red: 0.4, green: 0.3878170228, blue: 0, alpha: 1), #colorLiteral(red: 0.4, green: 0, blue: 0.1252574799, alpha: 1)]
			private static let bottomColor = #colorLiteral(red: 0.003921568627, green: 0.5725490196, blue: 0.8588235294, alpha: 1)
			
			static func getTopColor(index: Int) -> UIColor {
				guard index < topColors.count else {
					return .clear
				}
				return topColors[index].withAlphaComponent(0.5)
			}
			
			static func getBottomColor() -> UIColor {
				return bottomColor.withAlphaComponent(0.5)
			}
		}
		
		let topRightColor = GradientColors.getTopColor(index: index)
		let bottomLeftColor = GradientColors.getBottomColor()
		
		let gradient = CAGradientLayer()
		gradient.frame = size
		gradient.startPoint = CGPoint(x: 0, y: 1)
		gradient.endPoint = CGPoint(x: 1, y: 0)
		gradient.colors = [bottomLeftColor.cgColor, topRightColor.cgColor]
		
		if let topSubLayer = self.layer.sublayers?.first {
			self.layer.replaceSublayer(topSubLayer, with: gradient)
		} else {
			self.layer.insertSublayer(gradient, at: 0)
		}
	}
}
