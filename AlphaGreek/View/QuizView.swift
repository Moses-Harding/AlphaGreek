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
    
    //Stacks
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
    
    //Back Button
    var backButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    
    var backSpacer1 = UIView()
    var backSpacer2 = UIView()
    var backSpacer3 = UIView()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.helper.darkGreekBlue
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()
    
    //Points
    var secondBarStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    var pointsView = UIView()
    var pointsStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    var pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Points: "
        label.textColor = Colors.helper.darkGreekBlue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    var pointsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "X"
        label.textColor = Colors.helper.darkGreekBlue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var verticalLine1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.helper.darkGreekBlue
        return view
    }()
    
    
    //High Score
    var highScoreView = UIView()
    var highScoreStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    var highScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Highscore:"
        label.textColor = Colors.helper.darkGreekBlue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    var highSCoreCountLabel: UILabel = {
        let label = UILabel()
        label.text = "X"
        label.textColor = Colors.helper.darkGreekBlue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var verticalLine2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.helper.darkGreekBlue
        return view
    }()
    
    //Streak
    var streakView = UIView()
    var streakStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    var streakLabel: UILabel = {
        let label = UILabel()
        label.text = "Streak:"
        label.textAlignment = .center
        label.textColor = Colors.helper.darkGreekBlue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    var streakCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.textColor = Colors.helper.crayolaRed
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    //Question and answer views
    var line1: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.helper.darkGreekBlue
        return view
    }()
    var questionTextView = UIView()
    var line2: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.helper.darkGreekBlue
        return view
    }()
    var questionView = UIView()
    var line3: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.helper.darkGreekBlue
        return view
    }()
    var answerStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    var questionTextLabel = UILabel()
    var questionLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        setUpMainStack()
        setUpLabels()
        setUpStacks()
    }
    
    // MARK: Set Up View
    func setUpMainStack() {
        
        self.constrain(mainStack)
        
        let spacer1 = UIView()
        let spacer2 = UIView()
        let spacer3 = UIView()
        
        let children: [(UIView, CGFloat?)] = [(spacer1, 0.025), (topStack, 0.05), (spacer2, 0.025), (secondBarStack, 0.1), (spacer3, nil), (line1, 0.0025), (questionTextView, 0.125), (line2, 0.0025), (questionView, 0.4), (line3, 0.0025), (answerStack, 0.25)]
        
        mainStack.add(children)
    }
    
    func setUpLabels() {

        questionTextView.constrain(questionTextLabel, widthScale: 0.9)
        questionView.constrain(questionLabel)

        questionTextLabel.numberOfLines = 0
        questionTextLabel.textColor = Colors.helper.darkGreekBlue
        
        questionLabel.font = UIFont.systemFont(ofSize: 90)
        questionLabel.textColor = Colors.helper.darkGreekBlue
        
        questionLabel.textAlignment = .center
    }
    
    func setUpStacks() {
        
        topStack.addArrangedSubview(backButtonStack)

        secondBarStack.add([(pointsStack, 0.33), (verticalLine1, 0.0025), (highScoreStack, 0.33), (verticalLine2, 0.0025), (streakStack, 0.33)])
        
        verticalLine1.widthAnchor.constraint(equalToConstant: 2).isActive = true
        verticalLine2.widthAnchor.constraint(equalToConstant: 2).isActive = true
         
        pointsStack.add([pointsLabel, pointsCountLabel])
        highScoreStack.add([highScoreLabel, highSCoreCountLabel])
        streakStack.add([streakLabel, streakCountLabel])
        
        backButtonStack.add([backButton, backSpacer1, backSpacer2, backSpacer3])
    }
    
    
    // MARK: Add Answer + Labels
    // Unique for each LetterQuizViewController
    func addAnswer(answer: Answer, quizType: QuizType) {
        //Override This
    }
    
    func setLabels(from answer: Answer, questionType: QuizType, answerType: QuizType) {
        //Override This
    }
    
    
    //Set Points / Streak / HighScore Labels
    func setPoints() {
        pointsCountLabel.text = "\(delegate?.points ?? 0)"
        highSCoreCountLabel.text = "\(delegate?.highScore ?? 0)"
        if delegate?.streak ?? 0 > 0 {
            streakCountLabel.textColor = Colors.helper.darkGreekBlue
            streakCountLabel.text = "\(delegate?.streak ?? 0)"
        } else {
            streakCountLabel.textColor = Colors.helper.crayolaRed
            if delegate?.strikes == 0 {
                streakCountLabel.text = "0"
            } else if delegate?.strikes == 1 {
                streakCountLabel.text = "X"
            } else if delegate?.strikes == 2 {
                streakCountLabel.text = "XX"
            } else if delegate?.strikes == 3 {
                streakCountLabel.text = "XXX"
            }
        }
        
        secondBarStack.layoutSubviews()
    }
    
    //Clear labels, remove answer views
    func clear() {
        answerStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        questionTextLabel.text = ""
        questionLabel.text = ""
    }
    
    //Return to home screen
    @objc func goBack() {
            self.delegate?.back()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: AnswerView
// These are the answer "Panels" at the bottom
class AnswerView: UIView {
    
    var label = UILabel()
    var answer: Answer
    var wasTouched = false
    var delegate: QuizViewDelegate?
    
    init(answer: Answer, quizType: QuizType) {
        
        self.answer = answer
        
        super.init(frame: CGRect.zero)
        
        self.layer.cornerRadius = 5
        
        //Format Label
        constrain(label)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Colors.helper.darkGreekBlue
        label.textAlignment = .center
    }
    
    // If this panel is touched, check to see if the answer is correct, if it was already touched, and if it's currently animating. If not, set the background color.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard !wasTouched, let delegate = delegate else { return }
        
        let (answerCorrect, transitioningOrAnimating) = delegate.check(answer: answer)
        
        guard !transitioningOrAnimating else { return }
        
        if answerCorrect {
            self.backgroundColor = Colors.helper.emeraldGreen
            wasTouched = true
            delegate.proceedToNextQuestion()
        } else {
            wasTouched = true
            self.backgroundColor = Colors.helper.crayolaRed
        }
        label.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
