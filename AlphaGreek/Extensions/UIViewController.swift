//
//  UIViewController - Extensions.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/3/21.
//

import UIKit

extension UIViewController {
    
    // Allows easy adding of a child view controller
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    // Allows easy removal of a child view controller
    func remove() {
        guard parent != nil else {
            return
        }
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
