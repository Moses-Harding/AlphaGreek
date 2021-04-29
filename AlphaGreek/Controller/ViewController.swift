//
//  ViewController.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    var quizView = QuizView()
    var alphabet = AlphabetModel()
    
    var currentLetter: Letter?
    var points = 0
    var pointsToAdd = 2
    var strikes = 0
    var streak = 0
    
    var transitioning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        newRound()
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
    
    func newRound() {
        
        var allCases = Array<QuizType>(QuizType.allCases).shuffled()
        
        let questionType = allCases.popLast()!
        let answerType = allCases.popLast()!
        
        var answers = alphabet.randomList()
        
        currentLetter = answers[0]
        quizView.setLabels(from: currentLetter!, questionType: questionType, answerType: answerType)
        
        answers.shuffle()
        
        for letter in answers {
            quizView.addAnswer(letter: letter, quizType: answerType)
        }
    }
    
    func nextQuestion() {
        
        transitioning = true
        pointsToAdd = 3
        
        UIView.animate(withDuration: 0.2, animations: {
            self.quizView.questionLabel.alpha = 0
            self.quizView.letterView.alpha = 0
            self.quizView.answerStack.alpha = 0
        }, completion: { _ in
            self.quizView.clear()
            UIView.animate(withDuration: 0.2, animations: {
                self.newRound()
                self.quizView.questionLabel.alpha = 1
                self.quizView.letterView.alpha = 1
                self.quizView.answerStack.alpha = 1
            }) { _ in
                self.transitioning = false
            }
        })
    }
    
    func animatedMessage(_ message: String, completion: @escaping () -> ()) {
        
        let messageView = UIView()
        let label = UILabel()
        
        messageView.backgroundColor = darkGreekBlue
        messageView.alpha = 0
        messageView.layer.cornerRadius = 5
        messageView.constrain(label)
        
        label.textColor = .white
        label.text = message
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageView)
        messageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        messageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0.5, animations: {
            messageView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                messageView.alpha = 0
            }, completion: { _ in
                messageView.removeFromSuperview()
                completion()
            })
        })
    }
    
    func updatePoints(_ message: String, pointsLost: Bool, completion: @escaping () -> ()) {
        
        let messageView = UIView()
        let label = UILabel()
        
        if pointsLost {
            messageView.backgroundColor = crayolaRed
        } else {
            messageView.backgroundColor = emeraldGreen
        }
        messageView.alpha = 0
        messageView.layer.cornerRadius = 5
        messageView.constrain(label)
        
        label.textColor = .white
        label.text = message
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        
        let view = quizView.pointsLabel
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageView)
        messageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        messageView.widthAnchor.constraint(equalTo: messageView.heightAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        messageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0.5, animations: {
            messageView.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                messageView.alpha = 0
            }, completion: { _ in
                messageView.removeFromSuperview()
                completion()
            })
        })
    }
}

extension ViewController: QuizViewDelegate {
    
    func check(answer: Letter) -> (Bool, Bool) {
        
        let result = answer == currentLetter
        if !result && !transitioning {
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
    
    func proceed() {
        
        let completion = {
            self.points += self.pointsToAdd
            self.nextQuestion()
        }

        updatePoints("+\(pointsToAdd)", pointsLost: false, completion: completion)
    }
    
    func reset() {
        points = 0
        strikes = 0
        pointsToAdd = 2
        nextQuestion()
    }
    
    func gameOver() {
        animatedMessage("Strike 3 - Game Over") {
            self.reset()
        }
    }
}

protocol QuizViewDelegate {
    
    var points: Int {get set}
    var strikes: Int {get set}
    var streak: Int {get set}
    
    func check(answer: Letter) -> (Bool, Bool)
    func proceed()
    func reset()
    func gameOver()
    
}
