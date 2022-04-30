//
//  LetterQuizView.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/4/21.
//

import UIKit

// MARK: LetterQuizView
// These are the questions that are presented given the answer type. E.g. if the question is a greek lower case letter, and the answer is a greek upper case letter, then the question should be "What is the uppercase version of the following lowercase Greek letter?"
// You will never have the same question and answer type; that would result in a fatalError
class LetterQuizView: QuizView {
    
    override func setLabels(from answer: Answer, questionType: QuizType, answerType: QuizType) {
        
        guard let letter = answer as? Letter else {
            fatalError()
        }
        
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
        
        questionTextLabel.text = questionText
        questionLabel.text = text
        setPoints()
    }
    
    override func addAnswer(answer: Answer, quizType: QuizType = .greekLower) {
        
        guard let letter = answer as? Letter else {
            fatalError("Incorrect answer type passed")
        }
        
        let letterAnswerView = LetterAnswerView(letter: letter, quizType: quizType)
        letterAnswerView.delegate = delegate
        
        answerStack.addArrangedSubview(letterAnswerView)
    }
}

// MARK: LetterAnswerView
// Assigns text that was generated above to an AnswerView in the QuizView
class LetterAnswerView: AnswerView {
    
    init(letter: Letter, quizType: QuizType) {
        
        super.init(answer: letter, quizType: quizType)
        
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
        
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
