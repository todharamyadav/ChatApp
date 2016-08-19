//
//  Constraints.swift
//  Chat
//
//  Created by Dharamvir on 8/16/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintWithVisualFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

