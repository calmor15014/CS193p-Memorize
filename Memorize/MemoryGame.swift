//
//  MemoryGame.swift
//  Memorize
//
//  Created by James Spece on 10/9/20.
//
//  Model for the Memorize App

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        // Create empty array
        cards = Array<Card>()
        // Loop through all of the pairs requeted
        for pairIndex in 0..<numberOfPairsOfCards {
            // Get the content from the calling function
            let content = cardContentFactory(pairIndex)
            // Add two cards with the same content
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
