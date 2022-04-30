//
//  LetterQuizViewController.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/4/21.
//

import UIKit

// Each viewController takes a different type of AnswerBank model and has a unique HighScore. In its current implementation, it would actually be possible to just reuse one QuizViewController, but this is meant to allow flexibility for expansion in the future.

class GreekToEnglishLetterQuizViewController: QuizViewController {
    
    override func viewDidLoad() {
        
        self.quizView = LetterQuizView()
        self.answerBank = GreekToEnglishLetters()
        
        super.viewDidLoad()
    }
    
    override func setHighScore(_ newValue: Int) {
        AppData.greekToEnglishLetterHighScore = newValue
    }
    
    override func getHighScore() -> Int {
        return AppData.greekToEnglishLetterHighScore
    }
}

class EnglishToGreekLetterQuizViewController: QuizViewController {
    
    override func viewDidLoad() {
        
        self.quizView = LetterQuizView()
        self.answerBank = EnglishToGreekLetters()

        super.viewDidLoad()
    }
    
    override func setHighScore(_ newValue: Int) {
        AppData.englishToGreekLetterHighScore = newValue
    }
    
    override func getHighScore() -> Int {
        return AppData.englishToGreekLetterHighScore
    }
}

class UpperToLowerLetterQuizViewController: QuizViewController {
    
    override func viewDidLoad() {
        
        self.quizView = LetterQuizView()
        self.answerBank = UpperCaseToLowerCase()

        super.viewDidLoad()
    }
    
    override func setHighScore(_ newValue: Int) {
        AppData.upperToLowerHighScore = newValue
    }
    
    override func getHighScore() -> Int {
        return AppData.upperToLowerHighScore
    }
}

class LowerToUpperLetterQuizViewController: QuizViewController {
    
    override func viewDidLoad() {
        
        self.quizView = LetterQuizView()
        self.answerBank = LowerCaseToUpperCase()

        super.viewDidLoad()
    }
    
    override func setHighScore(_ newValue: Int) {
        AppData.lowerToUpperHighScore = newValue
    }
    
    override func getHighScore() -> Int {
        return AppData.lowerToUpperHighScore
    }
}

class SpellOutLetterQuizViewController: QuizViewController {
    
    override func viewDidLoad() {
        
        self.quizView = LetterQuizView()
        self.answerBank = SpellOutLetters()
       
        super.viewDidLoad()
    }
    
    override func setHighScore(_ newValue: Int) {
        AppData.spellOutLetterHighScore = newValue
    }
    
    override func getHighScore() -> Int {
        return AppData.spellOutLetterHighScore
    }
}
