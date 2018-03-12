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
        guard Bundle.main.path(forResource: nibName, ofType: "nib") != nil else {
            fatalError("No nib named \(nibName).xib exist.")
        }
        
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? Self
    }
}
