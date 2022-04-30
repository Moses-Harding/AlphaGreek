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
        add("α", "Α", "a", "αλφα", "alpha")
        add("β", "Β", "v", "βητα", "beta")
        add("γ", "Γ", "g", "γαμμα", "gamma")
        add("δ", "Δ", "th", "δελτα", "delta")
        add("ε", "Ε", "eh", "εψιλον", "epsilon")
        add("ζ", "Ζ", "z", "ζητα", "zeta")
        add("η", "Η", "ee", "ητα", "eta")
        add("θ", "Θ", "th", "θητα", "theta")
        add("ι", "Ι", "ee", "ιωτα", "iota")
        add("κ", "K", "k", "καππα", "kappa")
        add("λ", "Λ", "l", "λαμβδα", "lambda")
        add("μ", "M", "m", "μυ", "mu")
        add("ν", "Ν", "n", "νυ", "nu")
        add("ξ", "Ξ", "x", "ξι", "xi")
        add("ο", "Ο", "o", "ομικρον", "omicron")
        add("π", "Π", "p", "πι", "pi")
        add("Ρ", "ρ", "r", "ρω", "rho")
        add("σ", "Σ", "s", "σιγμα", "sigma")
        add("τ", "Τ", "t", "ταυ", "tau")
        add("υ", "Υ", "ee", "υψιλον", "upsilon")
        add("φ", "Φ", "f", "φι", "phi")
        add("χ", "Χ", "kh", "χι", "chi")
        add("ψ", "Ψ", "ps", "ψι", "psi")
        add("ω", "Ω", "o", "ωμεγα", "omega")
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

