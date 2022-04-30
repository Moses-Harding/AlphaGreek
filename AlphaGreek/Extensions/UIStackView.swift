//
//  UIStackView - Extensions.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/3/21.
//

import UIKit

extension UIStackView {
    
    // Sets most common defaults for UIStackView
    convenience init(_ axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, isLayoutMarginsRelativeArrangement: Bool = true, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        self.init(frame: CGRect.zero)
        
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
    }
    
    // Add children and specify how much of the stackview to occupy. User can pass "nil" for automatic sizing for a given view. Checks to make sure that there's never more than 100% allocated.
    func add(_ children: [(UIView, CGFloat?)], overrideErrorCheck: Bool = false) {
        
        var count: CGFloat = 0
        
        var constraintType: ConstraintType
        
        if self.axis == .horizontal {
            constraintType = .width
        } else {
            constraintType = .height
        }
        
        for (child, multiplier) in children {
            self.addArrangedSubview(child)
            if let multiplier = multiplier {
                self.setConstraint(for: child, constraintType, multiplier: multiplier)
                count += multiplier
            }
        }
        
        guard count <= 1 || overrideErrorCheck == true else {
            fatalError("Stack constraints exceed 100%")
        }
    }
    
    // A simple way to add many views to a stackview after it's already been initialized (instead of adding arranged subview each time)
    func add(_ children: [UIView]) {
        for child in children {
            self.addArrangedSubview(child)
        }
    }
}
