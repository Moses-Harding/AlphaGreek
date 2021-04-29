//
//  QuizView.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit



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
    var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = darkGreekBlue
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    var strikesStack: UILabel = {
        let label = UILabel()
        label.text = "X"
        label.textColor = crayolaRed
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //Points
    var pointsStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    var pointsView = UIView()
    var pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Points: 0"
        label.textColor = darkGreekBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    var highScoreView = UIView()
    var highScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Highscore: 0"
        label.textColor = darkGreekBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    var line1: UIView = {
        let view = UIView()
        view.backgroundColor = darkGreekBlue
        return view
    }()
    var questionView = UIView()
    var line2: UIView = {
        let view = UIView()
        view.backgroundColor = darkGreekBlue
        return view
    }()
    var letterView = UIView()
    var line3: UIView = {
        let view = UIView()
        view.backgroundColor = darkGreekBlue
        return view
    }()
    var answerStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    var questionLabel = UILabel()
    var letterLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        setUpMainStack()
        setUpLabels()
        setUpStacks()
    }
    
    func setUpMainStack() {
        
        self.constrain(mainStack)
        
        let spacer1 = UIView()
        let spacer2 = UIView()
        let spacer3 = UIView()
        
        mainStack.addArrangedSubview(spacer1)
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(spacer2)
        mainStack.addArrangedSubview(pointsStack)
        mainStack.addArrangedSubview(spacer3)
        mainStack.addArrangedSubview(line1)
        mainStack.addArrangedSubview(questionView)
        mainStack.addArrangedSubview(line2)
        mainStack.addArrangedSubview(letterView)
        mainStack.addArrangedSubview(line3)
        mainStack.addArrangedSubview(answerStack)
        
        spacer1.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.025).isActive = true
        topStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.05).isActive = true
        spacer2.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.025).isActive = true
        pointsStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1).isActive = true
        line1.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.0025).isActive = true
        questionView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.125).isActive = true
        line2.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.0025).isActive = true
        letterView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.4).isActive = true
        line3.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.0025).isActive = true
        answerStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    func setUpLabels() {
        questionView.constrain(questionLabel, widthScale: 0.9)
        letterView.constrain(letterLabel)
        pointsView.constrain(pointsLabel, widthScale: 0.9)
        highScoreView.constrain(highScoreLabel, widthScale: 0.9)
        
        questionLabel.numberOfLines = 0
        questionLabel.textColor = darkGreekBlue
        
        letterLabel.font = UIFont.systemFont(ofSize: 90)
        letterLabel.textColor = darkGreekBlue
        
        letterLabel.textAlignment = .center
    }
    
    func setUpStacks() {
        topStack.addArrangedSubview(strikesStack)
        topStack.addArrangedSubview(resetButton)
        
        pointsStack.addArrangedSubview(pointsView)
        pointsStack.addArrangedSubview(highScoreView)
    }
    
    func addAnswer(letter: Letter, quizType: QuizType = .greekLower) {
        
        let answer = AnswerView(letter: letter, quizType: quizType)
        answer.delegate = delegate
        
        answerStack.addArrangedSubview(answer)
    }
    
    func setLabels(from letter: Letter, questionType: QuizType = .englishPronunciation, answerType: QuizType = .greekLower) {
        
        var text: String!
        var questionText: String!
        
        switch questionType {
        case .greekLower:
            text = letter.greekLower
            switch answerType {
            case .greekLower:
                fatalError()
            case .greekUpper:
                questionText = "What is the uppercase version of the following lowercase Greek letter?"
            case .greekName:
                questionText = "How do you spell this letter's name in Greek?"
            case .englishName:
                questionText = "How do you spell letter's name in English?"
            case .englishPronunciation:
                questionText = "How would you pronounce this letter in English?"
            }
        case .greekUpper:
            text = letter.greekUpper
            switch answerType {
            case .greekLower:
                questionText = "What is the lowercase version of the following uppercase Greek letter?"
            case .greekUpper:
                fatalError()
            case .greekName:
                questionText = "How do you spell this letter's name in Greek?"
            case .englishName:
                questionText = "How do you spell letter's name in English?"
            case .englishPronunciation:
                questionText = "How would you pronounce this letter in English?"
            }
        case .greekName:
            text = letter.greekName
            switch answerType {
            case .greekLower:
                questionText = "Below you see a letter's name written out in Greek. Which letter is spelled out here?"
            case .greekUpper:
                questionText = "Below you see a letter's name written out in Greek. Which letter is spelled out here?"
            case .greekName:
                fatalError()
            case .englishName:
                questionText = "Below you see a letter's name written out in Greek. How would you spell it in English?"
            case .englishPronunciation:
                questionText = "Below you see a letter's name written out in Greek. How would you pronounce it in English?"
            }
        case .englishName:
            text = letter.englishName
            switch answerType {
            case .greekLower:
                questionText = "Below you see a Greek letter's name written out in English. Which letter is spelled out here?"
            case .greekUpper:
                questionText = "Below you see a Greek letter's name written out in English. Which letter is spelled out here?"
            case .greekName:
                questionText = "Below you see a Greek letter's name written out in English. How would you spell it in Greek?"
            case .englishName:
                fatalError()
            case .englishPronunciation:
                questionText = "Below you see a Greek letter's name written out in English. How would you pronounce it in English?"
            }
        case .englishPronunciation:
            text = letter.englishPronunciation
            switch answerType {
            case .greekLower:
                questionText = "Which Greek letter is pronounced like the below sound in English?"
            case .greekUpper:
                questionText = "Which Greek letter is pronounced like the below sound in English?"
            case .greekName:
                questionText = "How do you spell the Greek letter that is pronounced like the below sound in English?"
            case .englishName:
                questionText = "How do you spell the Greek letter that is pronounced like the below sound in English?"
            case .englishPronunciation:
                fatalError()
            }
        }
        
        questionLabel.text = questionText
        letterLabel.text = text
        setPoints()
    }
    
    func setPoints() {
        pointsLabel.text = "Points: \(delegate?.points ?? 0)"
        if delegate?.streak ?? 0 > 0 {
            strikesStack.textColor = emeraldGreen
            strikesStack.text = "Streak: \(delegate?.streak ?? 0)"
        } else {
            strikesStack.textColor = crayolaRed
            if delegate?.strikes == 0 {
                strikesStack.text = ""
            } else if delegate?.strikes == 1 {
                strikesStack.text = "Strikes: X"
            } else if delegate?.strikes == 2 {
                strikesStack.text = "Strikes: XX"
            } else if delegate?.strikes == 3 {
                strikesStack.text = " Strikes: XXX"
            }
        }
    }
    
    func clear() {
        answerStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        questionLabel.text = ""
        letterLabel.text = ""
    }
    
    @objc func reset() {
        delegate?.reset()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnswerView: UIView {
    
    var label = UILabel()
    var letter: Letter
    var delegate: QuizViewDelegate?
    
    init(letter: Letter, quizType: QuizType) {
        
        self.letter = letter
        
        super.init(frame: CGRect.zero)
        
        self.layer.cornerRadius = 5
        
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
        let (answerCorrect, transitioning) = delegate?.check(answer: letter) ?? (false, false)
        
        print(answerCorrect, transitioning)
        guard !transitioning else {
            return
        }
        
        if answerCorrect {
            self.backgroundColor = emeraldGreen
            delegate?.proceed()
        } else {
            self.backgroundColor = crayolaRed
        }
        label.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
