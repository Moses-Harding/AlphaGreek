//
//  UIView - Extensions.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

extension UIView {
    
    func constrain(_ child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(child)
        
        let constraints = [
            child.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            child.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            child.widthAnchor.constraint(equalTo: self.widthAnchor),
            child.heightAnchor.constraint(equalTo: self.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
