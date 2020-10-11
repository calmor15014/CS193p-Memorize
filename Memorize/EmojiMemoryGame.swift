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
    // Add property wrapper to call ObjectWillChange.send()
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    // Start a MemoryGame with emojis (strings)
    static func createMemoryGame() -> MemoryGame<String> {
        // Pick a few emojis to put on the cards
        let emojis: Array<String> = ["👻","🎃","🕷","💀","👺"]
        // Random function answer to Lecture 2 home # 4
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        // Tell the model a card was chosen
        model.choose(card: card)
    }
}
