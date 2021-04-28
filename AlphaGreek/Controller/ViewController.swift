//
//  ViewController.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import UIKit

class ViewController: UIViewController, QuizViewDelegate {
    
    var quizView = QuizView()
    var alphabet = AlphabetModel()
    
    var currentLetter: Letter?
    var points = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUp()
        
        newRound()
    }
    
    func setUp() {
        quizView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizView)
        
        let layout = view.safeAreaLayoutGuide
        
        quizView.topAnchor.constraint(equalTo: layout.topAnchor).isActive = true
        quizView.bottomAnchor.constraint(equalTo: layout.bottomAnchor).isActive = true
        quizView.leadingAnchor.constraint(equalTo: layout.leadingAnchor).isActive = true
        quizView.trailingAnchor.constraint(equalTo: layout.trailingAnchor).isActive = true
        
        quizView.delegate = self
    }
    
    func newRound() {
        
        var answers = alphabet.randomList()
        
        currentLetter = answers[0]
        quizView.setLabels(from: currentLetter!)
        
        answers.shuffle()
        
        for letter in answers {
            quizView.addAnswer(delegate: self, letter: letter)
        }
    }
    
    func reset() {
        
        points = 0
        
        nextQuestion()
    }
    
    func nextQuestion() {
        
        quizView.clear()
        newRound()
    }
}

extension ViewController: AnswerDelegate {
    
    func check(answer: Letter) -> Bool {
        if answer == currentLetter {
            points += 1
            nextQuestion()
            return true
        } else {
            return false
        }
    }
}

protocol AnswerDelegate {
    
    func check(answer: Letter) -> Bool
}

protocol QuizViewDelegate {
    
    var points: Int {get set}
    
}
