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
    
    // Stub to identify that the view can pass the intent to the model
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex: Int = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }

    // Example of internal/external argument naming
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return 0 // TODO: bogus!
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
        // Shuffle the cards (Lecture 2 homework item #2)
        cards.shuffle()
    }
    
    // Define what a card is, including a Type Parameter content var
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
