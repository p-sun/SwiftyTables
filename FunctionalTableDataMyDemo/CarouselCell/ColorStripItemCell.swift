//
//  ColorStripItemCell.swift
//  Collection View in a Table View Cell
//
//  Created by TSD051 on 2017-12-12.
//  Copyright © 2017 Paige Sun. All rights reserved.
//

import UIKit

class ColorStripItemCell: UICollectionViewCell, CarouselItemCell {
    typealias Model = UIColor
    
    static let size = CGSize(width: 120, height: 120)
    
    let colorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(colorView)
        colorView.pinToSuperView()
        
        _ = colorView.heightAnchor.activateConstraint(
            equalToConstant:  ColorStripItemCell.size.height, priority: 999)
        _ = colorView.widthAnchor.activateConstraint(
            equalToConstant:  ColorStripItemCell.size.width, priority: 999)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: UIColor) {
        colorView.backgroundColor = model
    }
}
