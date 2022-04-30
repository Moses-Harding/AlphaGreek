//
//  UIScrollView - Extensions.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/4/21.
//

import UIKit


enum ScrollDirection {
    case horizontal, vertical
}

extension UIScrollView {
    
    // An easy way to add a stackview to a scrollview
    func add(_ stackView: UIStackView, scrollDirection: ScrollDirection = .vertical, constant: CGFloat = 0, scale: CGFloat = 1) {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        if scrollDirection == .vertical {
            stackView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, constant: constant).isActive = true
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: scale).isActive = true
        } else {
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: self.widthAnchor, constant: constant).isActive = true
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: scale).isActive = true
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }
}
