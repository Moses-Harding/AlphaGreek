//
//  UIView - Extensions.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

extension UIView {
    
    func constrain(_ child: UIView, widthScale: CGFloat = 1, heightScale: CGFloat = 1) {
        child.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(child)
        
        let constraints = [
            child.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            child.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            child.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: widthScale),
            child.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightScale)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
