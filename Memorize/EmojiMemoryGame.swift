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
    @Published private var model: MemoryGame<String>
    private var currentTheme: EmojiMemoryGameTheme
    
    init() {
        currentTheme = EmojiMemoryGame.gameThemes().randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
    }
    
    // Start a MemoryGame with emojis (strings)
    private static func createMemoryGame(theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        // Random function answer to Lecture 2 homework # 4
        let pairs = theme.numberOfPairs ?? Int.random(in: 2..<theme.emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: pairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    static func gameThemes() -> [EmojiMemoryGameTheme] {
        var themes: [EmojiMemoryGameTheme] = []
        themes.append(EmojiMemoryGameTheme(name: "Halloween", emojis: ["👻","🎃","🕷","💀","👺"], color: Color.orange))
        themes.append(EmojiMemoryGameTheme(name: "Faces", emojis: ["😀","😉","🥺","😷","🤥"], color: Color.yellow, numberOfPairs: 5))
        themes.append(EmojiMemoryGameTheme(name: "Animals", emojis: ["🐶","🐭","🐷","🐤","🐥","🐼"], color: Color.gray, numberOfPairs: 6))
        themes.append(EmojiMemoryGameTheme(name: "Sports", emojis: ["🏈","⚾️","🎾","🎱","⛸","🏀"], color: Color.red, numberOfPairs: 6))
        themes.append(EmojiMemoryGameTheme(name: "Travel", emojis: ["🚗","🚕","✈️","🛴","🚜","🛳","🛸","🚃"], color: Color.blue, numberOfPairs: 8))
        themes.append(EmojiMemoryGameTheme(name: "Food", emojis: ["🍎","🥦","🥑","🍉","🌶","🧀"], color: Color.green))
        return themes
    }
        
    struct EmojiMemoryGameTheme {
        var name: String
        var emojis: [String]
        var color: Color
        var numberOfPairs: Int?
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
        currentTheme.color
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
