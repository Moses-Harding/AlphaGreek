//
//  AnswerBankModel.swift
//  AlphaGreek
//
//  Created by Moses Harding on 5/4/21.
//

import UIKit

protocol Answer {
    
    var key: String {get set}
}

protocol AnswerBankDelegate {
    
    // Collection of all possible answers
    var answerBank: [Answer] { get set }
    // Collection of all possible question types
    var possibleQuestionTypes: [QuizType] { get set }
    // Collection of all possible answer types
    var possibleAnswerTypes: [QuizType] { get set }
    
    func random() -> Answer
    func randomList() -> [Answer]
}
