//
//  NibView.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-19.
//

import Foundation

protocol NibView: class {}

extension NibView {
    static func instanceFromNib() -> Self? {
        let nibName = String(describing: self)
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? Self
    }
}
