//
//  SavedData.swift
//  AlphaGreek
//
//  Created by Moses Harding on 4/29/21.
//

import Foundation
import CoreData

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}


struct AppData {
    @Storage(key: "greekToEnglishLetterHighScore", defaultValue: 0)
    static var greekToEnglishLetterHighScore: Int
    
    @Storage(key: "englishToGreekLetterHighScore", defaultValue: 0)
    static var englishToGreekLetterHighScore: Int
    
    @Storage(key: "upperToLowerHighScore", defaultValue: 0)
    static var upperToLowerHighScore: Int
    
    @Storage(key: "lowerToUpperHighScore", defaultValue: 0)
    static var lowerToUpperHighScore: Int
    
    @Storage(key: "spellOutLetterHighScore", defaultValue: 0)
    static var spellOutLetterHighScore: Int
}
