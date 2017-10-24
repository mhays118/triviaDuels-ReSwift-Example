//
//  UIView+PKI.swift
//  Tribune
//
//  Created by Marcus Hays on 4/26/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func add(child: UIView, matchBounds: Bool = false) {
        self.addSubview(child)

        if matchBounds {
            child.bounds = bounds
            child.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                child.topAnchor.constraint(equalTo: self.topAnchor),
                child.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                child.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                child.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
    }
}
