//
//  MainScreenViewController.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/3/21.
//

import UIKit


class MainScreenViewController: ChildViewController {
    
    let mainView = MainScreenView()
    
    // Image is added here (rather than the view) because view is actually added on top of it. This is for the purpose of animatiion
    var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "building.columns")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.helper.darkGreekBlue
        return imageView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        view.constrain(backgroundImage, debugName: "Background Image")
        view.constrain(mainView, debugName: "Main View")
        
        mainView.delegate = self

    }
    
    // The transition animation remove the view by moving it up, exposing the background image
    func transitionAnimation() {
        
        let topConstraint = mainView.mainStack.bottomAnchor.constraint(equalTo: mainView.topAnchor)

        mainView.centerYConstraint?.isActive = false
        topConstraint.isActive = true
        self.mainView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5) {
            topConstraint.isActive = false
            self.mainView.centerYConstraint?.isActive = true
            self.mainView.layoutIfNeeded()
        }
    }
}

// This is in a protocol so that it's easily accessible by MainScreenView
extension MainScreenViewController: MainScreenDelegate {
    
    func start(_ containerState: ContainerState) {
        delegate?.transition(to: containerState)
    }
}

protocol MainScreenDelegate {
    
    func start(_ containerState: ContainerState)
}
