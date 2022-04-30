//
//  ViewController.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

class QuizViewController: ChildViewController {

    var quizView: QuizView!
    var answerBank: AnswerBankDelegate!
    
    var currentAnswer: Answer?
    var points = 0
    var pointsToAdd = 2
    var strikes = 0
    var streak = 0
    
    //Times
    var shortDuration: TimeInterval = 0.2
    var mediumDuration: TimeInterval = 0.5
    var longDuration: TimeInterval = 0.8
    var veryLongDuration: TimeInterval = 2

    
    // Highscore is stored in UserDefaults
    var highScore: Int {
        get {
            return getHighScore()
        }
        set {
            setHighScore(newValue)
        }
    }
    
    // Used to determine if an action is currently in process (and therefore answers shouldn't be tappable)
    var isAnimating  = false
    var transitioning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        newRound()
    }
    
    
    // There is a separate high score for each category, so each LetterQuizViewController has its own implementation
    func setHighScore(_ newValue: Int) {
        //Override this
    }
    
    func getHighScore() -> Int {
        //Override this
        return 0
    }
    
    func setUp() {
        
        quizView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizView)
        
        let layout = view.safeAreaLayoutGuide
        
        quizView.topAnchor.constraint(equalTo: layout.topAnchor).isActive = true
        quizView.bottomAnchor.constraint(equalTo: layout.bottomAnchor).isActive = true
        quizView.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 5).isActive = true
        quizView.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -5).isActive = true
        
        quizView.delegate = self
        
        view.backgroundColor = .white
        

    }
    
    // Get a random question and random answers from the answerBank model. Then set the set the relevant labels in the quiz view (answers / question)
    func newRound() {
        
        guard let questionType = answerBank.possibleQuestionTypes.randomElement(), let answerType = answerBank.possibleAnswerTypes.randomElement() else {
            fatalError("No question / answer type specified.")
        }
        guard var answers = answerBank?.randomList() else {
            fatalError("No answer bank passed")
        }
        
        currentAnswer = answers[0]
        quizView.setLabels(from: currentAnswer!, questionType: questionType, answerType: answerType)
        
        answers.shuffle()
        
        for answer in answers {
            quizView.addAnswer(answer: answer, quizType: answerType)
        }
    }
    
    // Fade out and back in while question refreshes
    func nextQuestionAnimation() {
        
        transitioning = true
        
        UIView.animate(withDuration: shortDuration, animations: {
            self.quizView.questionTextLabel.alpha = 0
            self.quizView.questionView.alpha = 0
            self.quizView.answerStack.alpha = 0
        }, completion: { _ in
            self.quizView.clear()
            UIView.animate(withDuration: 0.2, animations: {
                self.newRound()
                self.quizView.questionTextLabel.alpha = 1
                self.quizView.questionView.alpha = 1
                self.quizView.answerStack.alpha = 1
            }) { _ in
                self.transitioning = false
            }
        })
    }
    
    // This is the message that appears after losing (three strikes). It can be expanded in the future
    func animateSwipeDownMessage(_ message: String, middleAction: @escaping () -> (), completion: @escaping () -> ()) {
        
        let messageView = UIView()
        let label = UILabel()
        
        messageView.backgroundColor = Colors.helper.darkGreekBlue
        messageView.constrain(label)
        
        label.textColor = .white
        label.text = message
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageView)

        let topAnchor = messageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let bottomAnchor = messageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = messageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = messageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        topAnchor.isActive = true
        leadingAnchor.isActive = true
        trailingAnchor.isActive = true
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: longDuration, animations: { 
            bottomAnchor.isActive = true
            self.view.layoutIfNeeded()
        }, completion: { _ in
            middleAction()
            UIView.animate(withDuration: self.longDuration, animations: {
                topAnchor.isActive = false
                self.view.layoutIfNeeded()
            }, completion: { _ in
                messageView.removeFromSuperview()
                completion()
            })
        })
    }
    
    // Perform the animation associated with points update. Add a temporary view to backButtonStackView displaying how many points were added or lost
    func updatePoints(_ message: String, pointsLost: Bool, completion: @escaping () -> ()) {
        
        let messageView = UIView()
        let label = UILabel()
        
        if pointsLost {
            messageView.backgroundColor = Colors.helper.crayolaRed
        } else {
            messageView.backgroundColor = Colors.helper.emeraldGreen
        }
        
        messageView.alpha = 0
        messageView.layer.cornerRadius = 5
        messageView.constrain(label)
        
        label.textColor = .white
        label.text = message
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        
        let spacer = UIView()
        
        quizView.backButtonStack.removeArrangedSubview(quizView.backSpacer2)
        quizView.backButtonStack.removeArrangedSubview(quizView.backSpacer3)
        
        quizView.backButtonStack.addArrangedSubview(messageView)
        quizView.backButtonStack.addArrangedSubview(spacer)
        
        self.isAnimating = true

        UIView.animate(withDuration: longDuration, animations: {
            messageView.alpha = 0.3
        }, completion: { _ in
            UIView.animate(withDuration: self.longDuration, animations: {
                messageView.alpha = 0
            }, completion: { _ in
                messageView.removeFromSuperview()
                spacer.removeFromSuperview()
                self.isAnimating = false
                self.quizView.backButtonStack.add([self.quizView.backSpacer2, self.quizView.backSpacer3])
                completion()
            })
        })
    }
    
    func checkHighScore() {
        if points > highScore {
            highScore = points
        }
    }
}

extension QuizViewController: QuizViewDelegate {
    
    // Check if the answer is accurate (if not animating / transitioning). If third strike, trigger "gameOver"
    func check(answer: Answer) -> (Bool, Bool) {
        
        guard !transitioning && !isAnimating else { return (false, true) }

        let result = answer.key == currentAnswer?.key
        if !result {
            self.updatePoints("-1", pointsLost: true) {
                self.streak = 0
                self.points -= 1
                self.pointsToAdd -= 1
                self.strikes += 1
                self.quizView.setPoints()
                if self.strikes == 3 {
                    self.gameOver()
                }
            }
        } else if result {
            if strikes == 0 {
                streak += 1
            }
            self.strikes = 0
            self.quizView.setPoints()
        }
        return (result, transitioning)
    }
    
    func proceedToNextQuestion() {
        
        let completion = {
            self.points += self.pointsToAdd
            self.pointsToAdd = 2
            self.nextQuestionAnimation()
            self.checkHighScore()
        }

        updatePoints("+\(pointsToAdd)", pointsLost: false, completion: completion)
    }
    
    func reset() {
        
        points = 0
        strikes = 0
        streak = 0
        pointsToAdd = 2
        quizView.setPoints()
        nextQuestionAnimation()
    }
    
    // When gameOver, animate a message informing the user and resest all properties
    func gameOver() {
        
        animateSwipeDownMessage("Strike 3 - Game Over", middleAction: { self.reset() }, completion: {})
    }
    
    func back() {
        
        delegate?.transition(to: .mainScreen)
    }
}

protocol QuizViewDelegate {
    
    var points: Int {get set}
    var strikes: Int {get set}
    var streak: Int {get set}
    var highScore: Int {get set}
    var isAnimating: Bool {get set}
    
    func check(answer: Answer) -> (Bool, Bool)
    func proceedToNextQuestion()
    func back()
    func gameOver()
}
