//
//  ContainerViewController.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/3/21.
//

import UIKit

//Each state is a differenve view
enum ContainerState {
    case mainScreen, greekToEnglishLetterQuiz, englishToGreekLetterQuiz, upperToLowerLetterQuiz, lowerToUpperLetterQuiz, spellOutLetterQuiz
}

class ContainerViewController: UIViewController, ContainerViewControllerDelegate {
    
    private var state: ContainerState = .mainScreen
    var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition(to: .mainScreen)
    }
    
    // Create an instance of the appropriate view controller, add it as a child, and transition
    func transition(to state: ContainerState) {
        
        self.state = state
        self.currentViewController?.remove()
        
        var viewController: ChildViewController
        
        switch state {
        case .mainScreen:
            viewController = MainScreenViewController()
        case .greekToEnglishLetterQuiz:
            viewController = GreekToEnglishLetterQuizViewController()
        case .englishToGreekLetterQuiz:
            viewController = EnglishToGreekLetterQuizViewController()
        case .upperToLowerLetterQuiz:
            viewController = UpperToLowerLetterQuizViewController()
        case .lowerToUpperLetterQuiz:
            viewController = LowerToUpperLetterQuizViewController()
        case .spellOutLetterQuiz:
            viewController = SpellOutLetterQuizViewController()
        }
        
        //Add this view controller as a child of containerViewController (this is an extension of UIView)
        add(viewController)
        viewController.delegate = self
        
        // If it's a MainsScreenViewController, play an animation during transition
        if let mainViewController = viewController as? MainScreenViewController {
            mainViewController.transitionAnimation()
        }
    }

}

protocol ContainerViewControllerDelegate {

    // This is in a protocol so QuizView can access it easily
    func transition(to state: ContainerState)

}

class ChildViewController: UIViewController {
    
    var delegate: ContainerViewControllerDelegate?
}
