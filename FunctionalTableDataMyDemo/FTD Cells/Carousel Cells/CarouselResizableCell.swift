//
//  CarouselResizableCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD051 on 2018-01-17.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import Foundation


import UIKit

typealias CarouselResizableCell = CarouselCell<CarouselItemResizableCell>

class CarouselItemResizableCell: UICollectionViewCell, CarouselItemCell {
    
    typealias ItemModel = CGSize
    
    private let colorView = UIView()
    private var size = CGSize.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(colorView)
        colorView.pinToSuperView()
        colorView.backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func sizeForItem(model: ItemModel) -> CGSize {
        return model
    }
    
    func configure(model: ItemModel) {
        self.size = model
    }
}
