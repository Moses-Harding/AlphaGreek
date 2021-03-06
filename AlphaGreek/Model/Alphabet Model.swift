//
//  Alphabet Model.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import Foundation

// Each LetterModel has a defined set of question and answer types. E.g. "English To Greek Letters" can only possibly provide questions of type ".englishName" or ".englishPronunciation" and answers of type ".greekLower, ".greekName", and ".greekUpper"

class EnglishToGreekLetters: LetterModel {
    
    override init() {
        super.init()
        
        possibleQuestionTypes = [.englishName, .englishPronunciation]
        possibleAnswerTypes = [ .greekLower, .greekName, .greekUpper]
    }
}

class GreekToEnglishLetters: LetterModel {
    
    override init() {
        super.init()
        
        possibleQuestionTypes = [.greekLower, .greekName, .greekUpper]
        possibleAnswerTypes = [.englishName, .englishPronunciation]
    }
}

class UpperCaseToLowerCase: LetterModel {
    
    override init() {
        super.init()
        
        possibleQuestionTypes = [.greekUpper]
        possibleAnswerTypes = [.greekLower]
    }
}

class LowerCaseToUpperCase: LetterModel {
    
    override init() {
        super.init()
        
        possibleQuestionTypes = [.greekLower]
        possibleAnswerTypes = [.greekUpper]
    }
}

class SpellOutLetters: LetterModel {
    
    override init() {
        super.init()
        
        possibleQuestionTypes = [.englishName]
        possibleAnswerTypes = [.greekName]
    }
}

// All lettermodels have this bank of possible answers. The "key" is a lowercase greek letter - that is the unique property that's consistently checked against. A "Letter" object can be used to generate a question or an answer. You can ask the user to retrieve the value of a given letter based on any of its various properties (greek upper, greek lower, etc) and they will match based on the key

class LetterModel: AnswerBankDelegate {
    
    var answerBank = [Answer]()
    var possibleQuestionTypes: [QuizType] = []
    var possibleAnswerTypes: [QuizType] = []
    
    init() {
        addLetters()
    }
    
    func addLetters() {
        add("??", "??", "a", "????????", "alpha")
        add("??", "??", "v", "????????", "beta")
        add("??", "??", "g", "??????????", "gamma")
        add("??", "??", "th", "??????????", "delta")
        add("??", "??", "eh", "????????????", "epsilon")
        add("??", "??", "z", "????????", "zeta")
        add("??", "??", "ee", "??????", "eta")
        add("??", "??", "th", "????????", "theta")
        add("??", "??", "ee", "????????", "iota")
        add("??", "K", "k", "??????????", "kappa")
        add("??", "??", "l", "????????????", "lambda")
        add("??", "M", "m", "????", "mu")
        add("??", "??", "n", "????", "nu")
        add("??", "??", "x", "????", "xi")
        add("??", "??", "o", "??????????????", "omicron")
        add("??", "??", "p", "????", "pi")
        add("??", "??", "r", "????", "rho")
        add("??", "??", "s", "??????????", "sigma")
        add("??", "??", "t", "??????", "tau")
        add("??", "??", "ee", "????????????", "upsilon")
        add("??", "??", "f", "????", "phi")
        add("??", "??", "kh", "????", "chi")
        add("??", "??", "ps", "????", "psi")
        add("??", "??", "o", "??????????", "omega")
    }
    
    // This function is just used to add to the answerBank
    private func add(_ greekLower: String, _ greekUpper: String, _ englishPronunciation: String, _ greekName: String, _ englishName: String) {
        let letter = Letter(greekLower: greekLower, greekUpper: greekUpper, englishPronunciation: englishPronunciation, greekName: greekName, englishName: englishName, key: greekLower)
        answerBank.append(letter)
    }
    
    // Retrieve a random letter
    func random() -> Answer {
        return answerBank.randomElement()!
    }
    
    // Get a random list of letters
    func randomList() -> [Answer] {
        let numberOfAnswers = 4
        var tempList = answerBank.shuffled()
        var newList = [Answer]()
        for _ in 0 ..< numberOfAnswers {
            guard let letter = tempList.popLast() else {
                fatalError()
            }
            newList.append(letter)
        }
        
        return newList
    }
}

// One Letter has several forms, of which the user might be asked to specify any property, as well as a key meant for matching
class Letter: Answer {
    
    var greekLower: String
    var greekUpper: String
    var englishPronunciation: String
    var greekName: String
    var englishName: String
    var key: String
    
    init(greekLower: String, greekUpper: String, englishPronunciation: String, greekName: String, englishName: String, key: String) {

        self.greekLower = greekLower
        self.greekUpper = greekUpper
        self.englishPronunciation = englishPronunciation
        self.greekName = greekName
        self.englishName = englishName
        self.key = key
    }
}

