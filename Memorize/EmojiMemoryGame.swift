//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by James Spece on 10/9/20.
//
//  ViewModel for the Memorize App

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // Create an instance of the model, walled off from direct view access
    // @Published property wrapper to call ObjectWillChange.send()
    @Published private var model: MemoryGame<String> {
        didSet {
            // Homework 5 required task 2
            // Show json for current theme each time there's a new game.
            if let json = currentTheme.json {
                print(String(data: json, encoding: .utf8)!)
            }
        }
    }
    private var currentTheme: EmojiMemoryGameTheme
    
    init() {
        currentTheme = EmojiMemoryGame.gameThemes().randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
        // Isn't working in the didSet at first launch for some reason, so adding it to initializer too
        if let json = currentTheme.json {
            print(String(data: json, encoding: .utf8)!)
        }
    }
    
    // Start a MemoryGame with emojis (strings)
    private static func createMemoryGame(theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        // Random function answer to Lecture 2 homework # 4
        // Random function removed for Assignment 5 Required Task 1
        let pairs = theme.numberOfPairs //?? Int.random(in: 2..<theme.emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: pairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    static func gameThemes() -> [EmojiMemoryGameTheme] {
        var themes: [EmojiMemoryGameTheme] = []
        themes.append(EmojiMemoryGameTheme(name: "Halloween", emojis: ["👻","🎃","🕷","💀","👺"], color: UIColor.orange))
        themes.append(EmojiMemoryGameTheme(name: "Faces", emojis: ["😀","😉","🥺","😷","🤥"], color: UIColor.yellow))
        themes.append(EmojiMemoryGameTheme(name: "Animals", emojis: ["🐶","🐭","🐷","🐤","🐥","🐼"], color: UIColor.gray))
        themes.append(EmojiMemoryGameTheme(name: "Sports", emojis: ["🏈","⚾️","🎾","🎱","⛸","🏀"], color: UIColor.red))
        themes.append(EmojiMemoryGameTheme(name: "Travel", emojis: ["🚗","🚕","✈️","🛴","🚜","🛳","🛸","🚃"], color: UIColor.blue))
        themes.append(EmojiMemoryGameTheme(name: "Food", emojis: ["🍎","🥦","🥑","🍉","🌶","🧀"], color: UIColor.green))
        return themes
    }
        
    struct EmojiMemoryGameTheme: Codable {
        // Changed these to lets in Homework 5 as they are not changed once created, at this point anyway
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let color: UIColor.RGB
        
        // Homework 5 required task 2
        var json: Data? {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try? JSONEncoder().encode(self)
        }
        
        // Need an initializer to compute the numberOfPairs value at start time
        fileprivate init(name: String, emojis: [String], color: UIColor) {
            self.name = name
            self.emojis = emojis
            self.color = color.rgb
//            color.getRed(&self.color.red, green: &self.color.green, blue: &self.color.blue, alpha: &self.color.alpha)
            self.numberOfPairs = emojis.count // To simplify serialization
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Access to the current theme
    
    var themeName: String {
        currentTheme.name
    }
    
    var themeColor: Color {
        Color(currentTheme.color) // uses Color estension in UIColor+RGBA
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        // Tell the model a card was chosen
        model.choose(card: card)
    }
    
    func newGame() {
        // Reset the model by replacing it with a new model
        
        /* This resets the score for a new game, but homework instructions didn't require
           keeping the score concurrently as the score is in the model
           Maintaining score can be done by adding a function in the model to
           replace all cards
        */
        // Pick a random theme
        currentTheme = EmojiMemoryGame.gameThemes().randomElement()!
        // Replace the model
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
    }
}
