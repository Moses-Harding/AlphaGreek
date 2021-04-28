//
//  Alphabet Model.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/27/21.
//

import Foundation

class AlphabetModel {
    
    var alphabet = [Letter]()
    
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
    
    func add(_ greekLower: String, _ greekUpper: String, _ englishPronunciation: String, _ greekName: String, _ englishName: String) {
        let letter = Letter(greekLower: greekLower, greekUpper: greekUpper, englishPronunciation: englishPronunciation, greekName: greekName, englishName: englishName)
        alphabet.append(letter)
    }
    
    func random() -> Letter {
        return alphabet.randomElement()!
    }
    
    func randomList(_ numberOfLetters: Int = 4) -> [Letter] {
        var tempList = alphabet.shuffled()
        var newList = [Letter]()
        for _ in 0 ..< numberOfLetters {
            guard let letter = tempList.popLast() else {
                fatalError()
            }
            newList.append(letter)
        }
        
        return newList
    }
}

struct Letter {
    
    var greekLower: String
    var greekUpper: String
    var englishPronunciation: String
    var greekName: String
    var englishName: String
    
}

extension Letter: Equatable {
    
    static func == (lhs: Letter, rhs: Letter) -> Bool {
        return lhs.greekLower == rhs.greekLower
    }
}
