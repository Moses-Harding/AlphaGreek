//
//  QuizView.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

enum QuizType {
    case greekLower, greekUpper, greekName, englishName, englishPronunciation
}

class QuizView: UIView {
    
    //Delegate
    var delegate: QuizViewDelegate?
    
    //Views
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    var topStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    var pointsView: UILabel = {
        let label = UILabel()
        label.text = "Points: 0"
        label.textColor = darkGreekBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = darkGreekBlue
        return button
    }()
    
    var questionView = UIView()
    var letterView = UIView()
    var line1: UIView = {
        let view = UIView()
        view.backgroundColor = lightGreekBlue
        return view
    }()
    var line2: UIView = {
        let view = UIView()
        view.backgroundColor = lightGreekBlue
        return view
    }()
    var answerStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    
    var questionLabel = UILabel()
    var letterLabel = UILabel()

    init() {
        super.init(frame: CGRect.zero)
        
        setUpMainStack()
        setUpLabels()
        setUpTopStack()
    }
    
    func setUpMainStack() {
        
        self.constrain(mainStack)
        
        let spacer = UIView()
        
        mainStack.addArrangedSubview(spacer)
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(questionView)
        mainStack.addArrangedSubview(line1)
        mainStack.addArrangedSubview(letterView)
        mainStack.addArrangedSubview(line2)
        mainStack.addArrangedSubview(answerStack)
        
        topStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1).isActive = true
        questionView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.25).isActive = true
        line1.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.005).isActive = true
        letterView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.35).isActive = true
        line2.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.005).isActive = true
        answerStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    func setUpLabels() {
        questionView.constrain(questionLabel)
        letterView.constrain(letterLabel)
        
        questionLabel.numberOfLines = 0
        questionLabel.textColor = darkGreekBlue
        
        letterLabel.font = UIFont.systemFont(ofSize: 90)
        letterLabel.textColor = darkGreekBlue
        
        letterLabel.textAlignment = .center
    }
    
    func setUpTopStack() {
        topStack.addArrangedSubview(pointsView)
        topStack.addArrangedSubview(resetButton)
    }
    
    func addAnswer(delegate: AnswerDelegate, letter: Letter, quizType: QuizType = .greekLower) {
        
        let answer = AnswerView(delegate: delegate, letter: letter, quizType: quizType)
        
        answerStack.addArrangedSubview(answer)
    }
    
    func setLabels(from letter: Letter, quizType: QuizType = .englishPronunciation) {
        
        questionLabel.text = "Which of the below answers corresponds to the following letter:"
        
        var text: String!
        
        switch quizType {
        case .greekLower:
            text = letter.greekLower
        case .greekUpper:
            text = letter.greekUpper
        case .greekName:
            text = letter.greekName
        case .englishName:
            text = letter.englishName
            questionLabel.text = "Which of the below answers corresponds to the following english pronunciation - "
        case .englishPronunciation:
            text = letter.englishPronunciation
        }
        
        letterLabel.text = text
        pointsView.text = "Points: \(delegate?.points ?? 0)"
        
    }
    
    func clear() {
        answerStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        questionLabel.text = ""
        letterLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnswerView: UIView {
    
    var label = UILabel()
    var letter: Letter
    var delegate: AnswerDelegate
    
    init(delegate: AnswerDelegate, letter: Letter, quizType: QuizType) {
        
        self.letter = letter
        self.delegate = delegate
        
        super.init(frame: CGRect.zero)
        
        //Add Text
        var text: String!
        
        switch quizType {
        case .greekLower:
            text = letter.greekLower
        case .greekUpper:
            text = letter.greekUpper
        case .greekName:
            text = letter.greekName
        case .englishName:
            text = letter.englishName
        case .englishPronunciation:
            text = letter.englishPronunciation
        }
        
        //Format Label
        constrain(label)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = darkGreekBlue
        label.textAlignment = .center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let answerCorrect = delegate.check(answer: letter)
        if answerCorrect {
            self.backgroundColor = emeraldGreen
        } else {
            self.backgroundColor = crayolaRed
        }
        label.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
