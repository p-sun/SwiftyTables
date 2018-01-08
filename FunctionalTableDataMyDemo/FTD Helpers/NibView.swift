//
//  NibView.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-19.
//  Copyright © 2017 TribalScale. All rights reserved.
//

import Foundation

protocol NibView: class {}

extension NibView {
    static func instanceFromNib() -> UIView? {
        let nibName = String(describing: self)
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
    }
}

/*
 To allow initializing from nib, add this to TableCell and CollectionCell in FunctionalTableData
 
 if let nibView = ViewType.self as? NibView.Type, let instance = nibView.instanceFromNib() as? ViewType {
    view = instance
 } else {
    view = ViewType()
 }
 **/
