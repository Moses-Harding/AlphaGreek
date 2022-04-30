//
//  MainScreenView.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/3/21.
//

import UIKit

class MainScreenView: UIView {
    
    var delegate: MainScreenDelegate?
    
    // Set Up Stack
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    var spacer1 = UIView()
    
    // Set Up Welcome Message
    var topMessageView = UIView()
    var topMessageLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Γεια σου!
        
        AlphaGreek helps you learn Greek letters.
        """
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    var spacer2 = UIView()
    
    // Set Up Buttons
    var buttonView = UIView()
    var buttonScrollView = UIScrollView()
    var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    var englishToGreekLetterQuizButton: UIButton = {
        let button = UIButton()
        button.setTitle("English To Greek Letters", for: .normal)
        button.setTitleColor(Colors.helper.darkGreekBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startEnglishToGreekLetterQuiz), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var greekToEnglishLetterQuizButton: UIButton = {
        let button = UIButton()
        button.setTitle("Greek To English Letters", for: .normal)
        button.setTitleColor(Colors.helper.darkGreekBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startGreekToEnglishLetterQuiz), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var upperCaseToLowerCaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Uppercase To Lowercase", for: .normal)
        button.setTitleColor(Colors.helper.darkGreekBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startUpperToLowerLetterQuiz), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var lowerCaseToUpperCaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lowercase To Uppercase", for: .normal)
        button.setTitleColor(Colors.helper.darkGreekBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startUpperToLowerLetterQuiz), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var spellOutLettersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spell Out Letters", for: .normal)
        button.setTitleColor(Colors.helper.darkGreekBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startSpellOutLetterQuiz), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var spacer3 = UIView()
    
    //Constraints
    var centerXConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: CGRect.zero)
        
        setUpMainStack()
        setUpLabels()
        setUpButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set UP Views
    func setUpMainStack() {
        mainStack.backgroundColor = Colors.helper.darkGreekBlue
        (centerXConstraint: centerXConstraint, centerYConstraint: centerYConstraint, widthConstraint: widthConstraint, heightConstraint: heightConstraint) = self.constrain(mainStack, .scale, debugName: "Main Stack")
        
        mainStack.add([(spacer1, 0.1), (topMessageView, 0.2), (spacer2, 0.1), (buttonView, 0.5), (spacer3, nil)])
    }
    
    func setUpLabels() {
        topMessageView.constrain(topMessageLabel, widthScale: 0.9)
    }
    
    func setUpButtons() {
        buttonView.constrain(buttonScrollView, widthScale: 0.8)
        buttonScrollView.add(buttonStack)
        
        let spacer = UIView()
        buttonStack.add([(spacer, nil), (englishToGreekLetterQuizButton, 0.15), (greekToEnglishLetterQuizButton, 0.15), (upperCaseToLowerCaseButton, 0.15), (lowerCaseToUpperCaseButton, 0.15), (spellOutLettersButton, 0.15)])
    }
}

//MARK: Actions
// Start the various quiz types
extension MainScreenView {
    
    func startQuizAnimation(_ containerState: ContainerState) {
        
        self.centerYConstraint?.isActive = false
        mainStack.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        UIView.animate(withDuration: 2, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            self.delegate?.start(containerState)
        })
    }
    
    @objc func startEnglishToGreekLetterQuiz() {
        startQuizAnimation(.englishToGreekLetterQuiz)
    }
    
    @objc func startGreekToEnglishLetterQuiz() {
        startQuizAnimation(.greekToEnglishLetterQuiz)
    }
    
    @objc func startUpperToLowerLetterQuiz() {
        startQuizAnimation(.upperToLowerLetterQuiz)
    }
    
    @objc func startLowerToupperLetterQuiz() {
        startQuizAnimation(.lowerToUpperLetterQuiz)
    }
    
    @objc func startSpellOutLetterQuiz() {
        startQuizAnimation(.spellOutLetterQuiz)
    }
}
