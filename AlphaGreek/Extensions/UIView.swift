//
//  UIView - Extensions.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

enum ConstraintType {
    case height, width, centerX, centerY, leading, trailing, top, bottom
}

enum ConstraintMethod {
    case scale, edges
}

extension UIView {
    
    // Easily constrain a view using either the "Scale" or "Edges" method (matching width/height vs leading/trailing). Assign debug names to each and optionally return the constraints. Allows exceptions (e.g. if you don't want to add a Top constraint)
    @discardableResult
    func constrain(_ child: UIView, _ constraintMethod: ConstraintMethod = .scale, widthScale: CGFloat = 1, heightScale: CGFloat = 1, padding: CGFloat = 0, except: [ConstraintType] = [], debugName: String = "Unnamed View") -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint){
        child.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(child)

        let heightConstraint = child.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: heightScale)
        let widthConstraint = child.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: widthScale)
        let centerYConstraint = child.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerXConstraint = child.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let leadingConstraint = child.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding)
        let trailingConstraint = child.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        let topConstraint = child.topAnchor.constraint(equalTo: self.topAnchor, constant: padding)
        let bottomConstraint = child.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        
        centerXConstraint.identifier = "\(debugName) - Custom Constraint - Center X"
        centerYConstraint.identifier = "\(debugName) - Custom Constraint - Center Y"
        widthConstraint.identifier = "\(debugName) - Custom Constraint - Width"
        heightConstraint.identifier = "\(debugName) - Custom Constraint - Height"
        leadingConstraint.identifier = "\(debugName) - Custom Constraint - Leading"
        trailingConstraint.identifier = "\(debugName) - Custom Constraint - Trailing"
        topConstraint.identifier = "\(debugName) - Custom Constraint - Top"
        bottomConstraint.identifier = "\(debugName) - Custom Constraint - Bottom"
        
        var constraintTuple: (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)
        
        if constraintMethod == .scale {
            NSLayoutConstraint.activate([heightConstraint, widthConstraint, centerYConstraint, centerXConstraint])
        
            constraintTuple = (centerXConstraint: centerXConstraint, centerYConstraint: centerYConstraint, widthConstraint: widthConstraint, heightConstraint: heightConstraint)
        } else {
            
            NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
            
            constraintTuple = (leadingConstraint: leadingConstraint, trailingConstraint: trailingConstraint, topConstraint: topConstraint, bottomConstraint: bottomConstraint)
        }
        
        except.forEach { exception in
            switch exception {
            case .height:
                heightConstraint.isActive = false
            case .width:
                widthConstraint.isActive = false
            case .centerX:
                centerXConstraint.isActive = false
            case .centerY:
                centerYConstraint.isActive = false
            case .leading:
                leadingConstraint.isActive = false
            case .trailing:
                trailingConstraint.isActive = false
            case .top:
                topConstraint.isActive = false
            case .bottom:
                bottomConstraint.isActive = false
            }
        }
        
        return constraintTuple
    }
    
    // Set an individual constraint, has the ability to add as a child if not already done so. Gives a custom name and optionally returns new constraint.
    @discardableResult
    func setConstraint(for child: UIView, _ constraintType: ConstraintType, addAsChild: Bool = false, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        
        if addAsChild {
            self.addSubview(child)
            child.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if constraintType != .height && constraintType != .width && multiplier != 1 {
            print("Warning - multiplier has no effect")
        }
        
        var constraint: NSLayoutConstraint
        
        switch constraintType {
        case .top:
            constraint = child.topAnchor.constraint(equalTo: self.topAnchor, constant: constant)
        case .bottom:
            constraint = child.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: constant)
        case .leading:
            constraint = child.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
        case .trailing:
            constraint = child.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constant)
        case .centerX:
            constraint = child.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
        case .centerY:
            constraint = child.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: constant)
        case .height:
            constraint = child.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier, constant: constant)
        case .width:
            constraint = child.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier, constant: constant)
        }
        
        constraint.isActive = true
        constraint.identifier = "Custom Constraint - \(constraintType)"
        
        return constraint
    }
}
