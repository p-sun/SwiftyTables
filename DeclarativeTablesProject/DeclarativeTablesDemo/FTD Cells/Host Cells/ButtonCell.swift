//
//  ButtonCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by TSD040 on 2018-03-12.
//  Copyright © 2018 TribalScale. All rights reserved.
//

import UIKit
import DeclarativeTables

//typealias ButtonCell = HostCell<UIButton, ButtonState, LayoutMarginsTableItemLayout>
//
//struct ButtonState: Equatable, StateType {
//    let title: String
//    let action: () -> Void
//    typealias View = UIButton
//    
//    public static func updateView(_ view: UIButton, state: ButtonState?) {
//        guard let state = state else {
//            view.setTitle(nil, for: .normal)
//        
////            view.set
////            view.removeControlEvent(.touchUpInside)
//            return
//        }
//        
//        view.titleLabel?.font = UIFont.systemFont(ofSize: 22)
//        if #available(iOS 11.0, *) {
//            view.contentHorizontalAlignment = .leading
//        } else {
//            // Fallback on earlier versions
//        }
//        view.setTitle(state.title, for: .normal)
//        // Callback support for UIControl using the `ActionKit` library.
//        // Use whatever technique you prefer to achieve the same
//        
////        view.add
//        
////        view.addTarget(self, action: #selector(action), for: .touchUpInside)
//    }
//    
//    
//    static func ==(lhs: ButtonState, rhs: ButtonState) -> Bool {
//        return lhs.title == rhs.title
//    }
//}

